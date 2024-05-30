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
    var preferences: [HttpClientConfig]
    
    public init(@HttpClientConfigBuilder preferences: () -> [HttpClientConfig] = { [] }) {
        self.preferences = preferences()
    }
}

// MARK: - Public methods
public extension HttpClient {
    func copy(
        @HttpClientConfigBuilder preferences: () -> [HttpClientConfig] = { [] }
    ) -> HttpClient {
        var client = self
        client.preferences += preferences()
        
        return client
    }
    
    func request(
        _ convertible: URLConvertible,
        @HttpClientConfigBuilder preferences: () -> [HttpClientConfig] = { [] }
    ) async throws -> HttpResponse {
        let defaultRequest = self.preferences.request()
        let component = try convertible.asURL()
        let url = if let url = defaultRequest.url {
            url.appendingPathComponent(component.absoluteString)
        } else {
            component
        }
        
        var request = defaultRequest
        request.url = url
        
        return try await preferences()
            .request(initial: request)
            .response
    }
}
