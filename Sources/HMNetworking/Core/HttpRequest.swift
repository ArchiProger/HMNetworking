//
//  HttpRequest.swift
//
//
//  Created by Archibbald on 30.05.2024.
//

import Foundation
import Alamofire

extension Session: @unchecked @retroactive Sendable { }
extension AFDataResponse: @unchecked @retroactive Sendable { }

public typealias PreparePerform = @Sendable (HttpRequest) throws -> HttpRequest

@dynamicMemberLookup
public struct HttpRequest: Sendable {
    var urlRequest: URLRequest
    var credential: URLCredential?
    var mode: RequestMode.Mode = .request
    var formData: MultipartFormData = .init()
    var prepare: PreparePerform = { $0 }
    var validators: [ResponseValidatorType] = []
    var cache: HttpCache? = nil
    var session: Session
    
    public init(_ url: URLConvertible, session: Session = AF) throws {
        self.urlRequest = try .init(url: url, method: .get)
        self.session = session
    }
    
    public init(session: Session = AF) {
        try! self.init("https://www.google.com", session: session)
        self.url = nil
    }
    
    var configuration: URLSessionConfiguration {
        get {
            session.sessionConfiguration
        }
        
        set {
            session = Session(configuration: newValue)
        }
    }
    
    var request: DataRequest {
        get throws {
            var request = try prepare(self)
            request.url = encodeURL(request.url)
            
            let result = session.request(request.urlRequest)
            
            guard let credential else { return result }
            
            return result.authenticate(with: credential)
        }
    }
    
    var uploadRequest: UploadRequest {
        get throws {
            var request = try prepare(self)
            request.url = encodeURL(request.url)
            
            let result = session.upload(multipartFormData: formData, with: request.urlRequest)
            
            guard let credential else { return result }
            
            return result.authenticate(with: credential)
        }
    }
    
    func encodeURL(_ url: URL?) -> URL? {
        guard let url else { return url }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if let encodedPath = components?.path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            components?.path = encodedPath
        }
        
        if let query = components?.query {
            components?.percentEncodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        }
        
        return components?.url
    }
}

// MARK: - Public methods
public extension HttpRequest {
    subscript<T>(dynamicMember keyPath: WritableKeyPath<URLRequest, T>) -> T {
        get {
            urlRequest[keyPath: keyPath]
        }
        set(value) {
            urlRequest[keyPath: keyPath] = value
        }
    }
    
    var response: HttpResponse {
        get async throws {
            let request = switch mode {
                case .request: try request
                case .upload: try uploadRequest
            }
            
            if let response = cache?.cachedResponse(for: self) {
                return response
            }
            
            let response = await withUnsafeContinuation { continuation in
                request
                    .response { response in
                        continuation.resume(returning: response)
                    }
            }
            
            var result = HttpResponse(from: response, with: self)
            for validator in validators {
                result = try await validator.execute(for: result)
            }
            
            cache?.save(result)
            
            return result
        }
    }
}
