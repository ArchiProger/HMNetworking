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
    var session: Session
    var defaultRequest = DefaultRequest()
    var defaultPlugins: [PluginType] = []
    
    public let plugins: [PluginType]
    public let preferences: [HttpDefaultRequestPreference]
    
    // MARK: - Initializers
    public init(
        session: Session = AF,
        @HttpPluginsBuilder plugins: () -> [PluginType] = { [] },
        @HttpDefaultRequestBuilder preferences: () -> [HttpDefaultRequestPreference]
    ) {
        self.plugins = plugins()
        self.preferences = preferences()
        self.session = session
        self.defaultRequest = defaultRequest.apply(preferences: self.preferences)
        self.defaultPlugins += self.plugins
    }
    
    public init(
        session: Session = AF,
        @HttpPluginsBuilder plugins: () -> [PluginType] = { [] }
    ) {
        self.init(session: session, plugins: plugins, preferences: { })
    }
        
    public func copy(@HttpDefaultRequestBuilder preferences: () -> [HttpDefaultRequestPreference]) -> HttpClient {
        HttpClient {
            self.plugins
        } preferences: {
            self.preferences
            preferences()
        }
    }
    
    // MARK: - Basic requests
    @discardableResult
    public func request(_ convertible: URLConvertible,
                        @HttpPluginsBuilder plugins: () -> [PluginType] = { [] }
    ) async throws -> AFDataResponse<Data?> {
        try await request(convertible, plugins: plugins, preferences: { })
    }
    
    @discardableResult
    public func request(_ convertible: URLConvertible,
                        @HttpPluginsBuilder plugins: () -> [PluginType] = { [] },
                        @HttpRequestBuilder preferences: () -> [HttpRequestPreference]
    ) async throws -> AFDataResponse<Data?> {
        
        let url = defaultRequest.host + convertible
        let request = try defaultRequest.prepare(URLRequest(url: url, method: .get, headers: defaultRequest.headers))
            .apply(preferences: preferences())
        
        let handler = session.request(request)
        let response = await withUnsafeContinuation { continuation in
            handler
                .apply(plugins: defaultPlugins + plugins())
                .response { response in
                    continuation.resume(returning: response)
                }
        }
        
        return try defaultRequest.responseHandler(response)
    }
    
    // MARK: - Uploading requests
    
    @discardableResult
    public func upload(_ convertible: URLConvertible,
                       multipartFormData: @escaping (MultipartFormData) -> Void,
                       @HttpPluginsBuilder plugins: () -> [PluginType] = { [] }
    ) async throws -> AFDataResponse<Data?> {
        try await upload(convertible, multipartFormData: multipartFormData, plugins: plugins, preferences: { })
    }
    
    @discardableResult
    public func upload(_ convertible: URLConvertible,
                       multipartFormData: @escaping (MultipartFormData) -> Void,
                       @HttpPluginsBuilder plugins: () -> [PluginType] = { [] },
                       @HttpRequestBuilder preferences: () -> [HttpRequestPreference]
    ) async throws -> AFDataResponse<Data?> {
        
        let url = defaultRequest.host + convertible
        let request = try defaultRequest.prepare(URLRequest(url: url, method: .get, headers: defaultRequest.headers))
            .apply(preferences: preferences())
                
        let handler = session.upload(multipartFormData: multipartFormData, with: request)
        let response = await withUnsafeContinuation { continuation in
            handler
                .apply(plugins: defaultPlugins + plugins())
                .response { response in
                    continuation.resume(returning: response)
                }
        }
        
        return try defaultRequest.responseHandler(response)
    }
}
