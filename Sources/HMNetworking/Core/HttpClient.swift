//
//  HttpClient.swift
//
//
//  Created by Артур Данилов on 08.01.2024.
//

import Foundation
import Alamofire

/// A network client that sends and processes network requests
/// # Easy setup
/// ```swift
/// // Configure client
/// let client = HttpClient()
///
/// // Making request
/// let response = try await client.request("https://www.example.com")
/// ```
/// 
/// # Default params
/// ```swift
/// let client = HttpClient {
///     HttpHeaders {
///         Header(.contentType("application/json; charset=UTF-8"))
///     }
/// }
/// ```
public struct HttpClient {
    var defaultRequest: HttpRequest
    
    public init(@HttpClientConfigBuilder preferences: () -> [HttpClientConfig]) {
        self.defaultRequest = preferences().request
    }
    
    public init() {
        self.defaultRequest = .empty
    }
}

// MARK: - Public methods
public extension HttpClient {
//    func request(_ url: URLConvertible) throws -> HttpRequest {
//        
//    }
}
