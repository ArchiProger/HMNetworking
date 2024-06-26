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
public final class HttpClient: Sendable {
    nonisolated(unsafe)
    var preferences: [HttpClientConfig]
    
    public init(@HttpClientConfigBuilder preferences: () -> [HttpClientConfig] = { [] }) {
        self.preferences = preferences()
    }
    
    func request(_ convertible: URLConvertible, preferences: [HttpClientConfig]) throws -> HttpRequest {
        let preferences = self.preferences + preferences
        let component = try convertible.asURL()
        
        var request = preferences.request()
        request.url = if let url = request.url {
            url.appendingPathComponent(component.absoluteString)
        } else {
            component
        }
        
        return request
    }
}

// MARK: - Public methods
public extension HttpClient {
    func copy(
        @HttpClientConfigBuilder preferences: () -> [HttpClientConfig] = { [] }
    ) -> HttpClient {
        self.preferences += preferences()
        
        return self
    }
    
    @discardableResult
    func request(
        _ convertible: URLConvertible,
        @HttpClientConfigBuilder preferences: () -> [HttpClientConfig] = { [] }
    ) async throws -> HttpResponse {
        try await request(convertible, preferences: preferences()).response
    }
    
    @discardableResult
    func upload(
        _ convertible: URLConvertible,
        @HttpClientConfigBuilder preferences: () -> [HttpClientConfig] = { [] }
    ) async throws -> HttpResponse {
        var request = try request(convertible, preferences: preferences())
        request.mode = .upload
        
        return try await request.response
    }
}
