//
//  Authentication.swift
//  HMNetworking
//
//  Created by Archibbald on 31.05.2024.
//

import Foundation

public struct Authentication: HttpClientConfig {
    var perform: @Sendable (HttpRequest) -> HttpRequest
    
    public init(credential: URLCredential) {
        perform = {
            var result = $0
            result.credential = credential
            
            return result
        }
    }
    
    public init(_ value: String) {
        perform = {
            var result = $0
            result.headers.add(.authorization(value))
            
            return result
        }
    }
    
    public init(bearer token: String) {
        perform = {
            var result = $0
            result.headers.add(.authorization(bearerToken: token))
            
            return result
        }
    }
    
    public init(username: String, password: String) {
        perform = {
            var result = $0
            result.headers.add(.authorization(username: username, password: password))
            
            return result
        }
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        perform(request)
    }
}
