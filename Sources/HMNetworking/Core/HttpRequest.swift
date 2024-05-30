//
//  HttpRequest.swift
//
//
//  Created by Archibbald on 30.05.2024.
//

import Foundation
import Alamofire

@dynamicMemberLookup
public struct HttpRequest {
    var urlRequest: URLRequest
    var credential: URLCredential?
    var session: Session
    
    init(_ url: URLConvertible, session: Session = AF) throws {
        self.urlRequest = try .init(url: url, method: .get)
        self.session = session
    }
    
    var request: DataRequest {
        let result = session.request(urlRequest)
        
        guard let credential else { return result }
        
        return result.authenticate(with: credential)
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
            let response = await withUnsafeContinuation { continuation in
                request
                    .response { response in
                        continuation.resume(returning: response)
                    }
            }
            
            return try .init(from: response, with: self)
        }
    }
}
