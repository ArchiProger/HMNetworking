//
//  HttpRequest.swift
//
//
//  Created by Archibbald on 30.05.2024.
//

import Foundation
import Alamofire

public typealias PreparePerform = (HttpRequest) throws -> HttpRequest
public typealias ResponseHandler = (HttpResponse) throws -> HttpResponse

@dynamicMemberLookup
public struct HttpRequest {
    var urlRequest: URLRequest
    var credential: URLCredential?
    var prepare: PreparePerform = { $0 }
    var validator: ResponseHandler = { $0 }
    var session: Session
    
    init(_ url: URLConvertible, session: Session = AF) throws {
        self.urlRequest = try .init(url: url, method: .get)
        self.session = session
    }
    
    var request: DataRequest {
        get throws {
            let request = try prepare(self)
            let result = session.request(request.urlRequest)
            
            guard let credential else { return result }
            
            return result.authenticate(with: credential)
        }
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
            
            return try validator(.init(from: response, with: self))
        }
    }
}
