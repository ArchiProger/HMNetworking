//
//  HttpRequest.swift
//
//
//  Created by Archibbald on 30.05.2024.
//

import Foundation
import Alamofire

public typealias PreparePerform = (HttpRequest) throws -> HttpRequest
public typealias ResponseValidator = (HttpResponse) async throws -> HttpResponse

@dynamicMemberLookup
public struct HttpRequest {
    var urlRequest: URLRequest
    var credential: URLCredential?
    var formData: MultipartFormData = .init()
    var prepare: PreparePerform = { $0 }
    var validators: [ResponseValidator] = []
    var session: Session
    
    init(_ url: URLConvertible, session: Session = AF) throws {
        self.urlRequest = try .init(url: url, method: .get)
        self.session = session
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

// MARK: - Empty request
public extension HttpRequest {
    static let empty: HttpRequest = {
        var request = try! HttpRequest("https://www.google.com")
        request.url = nil
        
        return request
    }()
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
            let request = try request
            let response = await withUnsafeContinuation { continuation in
                request
                    .response { response in
                        continuation.resume(returning: response)
                    }
            }
            
            var result = HttpResponse(from: response, with: self)
            for validator in validators {
                result = try await validator(result)
            }
            
            return result
        }
    }
    
    var uploadResponse: HttpResponse {
        get async throws {
            let request = try uploadRequest
            let response = await withUnsafeContinuation { continuation in
                request
                    .response { response in
                        continuation.resume(returning: response)
                    }
            }
            
            var result = HttpResponse(from: response, with: self)
            for validator in validators {
                result = try await validator(result)
            }
            
            return result
        }
    }
}
