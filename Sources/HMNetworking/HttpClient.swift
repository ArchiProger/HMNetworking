//
//  HttpClient.swift
//
//
//  Created by Артур Данилов on 08.01.2024.
//

import Foundation
import Alamofire

public struct HttpClient {
    var session: Session
    var defaultRequest = DefaultRequest()
    var defaultPlugins: [PluginType] = []
    
    public init(
        session: Session = AF,
        @HttpPluginsBuilder plugins: () -> [PluginType] = { [] },
        @HttpDefaultRequestBuilder preferences: () -> [HttpDefaultRequestPreference]
    ) {
        self.session = session
        self.defaultRequest = defaultRequest.apply(preferences: preferences())
        self.defaultPlugins = plugins()
    }
    
    public init(
        session: Session = AF,
        @HttpPluginsBuilder plugins: () -> [PluginType] = { [] }
    ) {
        self.init(session: session, plugins: plugins, preferences: { })
    }
    
    // MARK: - Basic requests
    public func request(_ convertible: URLConvertible,
                        @HttpPluginsBuilder plugins: () -> [PluginType] = { [] }
    ) async throws -> AFDataResponse<Data?> {
        try await request(convertible, plugins: plugins, preferences: { })
    }
    
    public func request(_ convertible: URLConvertible,
                        @HttpPluginsBuilder plugins: () -> [PluginType] = { [] },
                        @HttpRequestBuilder preferences: () -> [HttpRequestPreference]
    ) async throws -> AFDataResponse<Data?> {
        
        let url = defaultRequest.host + convertible
        let request = try URLRequest(url: url, method: .get, headers: defaultRequest.headers)
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
    
    // MARK: - Download requests
    
    public func upload(_ convertible: URLConvertible,
                       @HttpPluginsBuilder plugins: () -> [PluginType] = { [] }
    ) async throws -> AFDataResponse<Data?> {
        try await upload(convertible, plugins: plugins, preferences: { })
    }
    
    public func upload(_ convertible: URLConvertible,
                       @HttpPluginsBuilder plugins: () -> [PluginType] = { [] },
                       @HttpRequestBuilder preferences: () -> [HttpRequestPreference]
    ) async throws -> AFDataResponse<Data?> {
        
        let url = defaultRequest.host + convertible
        let request = try URLRequest(url: url, method: .get, headers: defaultRequest.headers)
            .apply(preferences: preferences())
        
        let data = request.httpBody ?? Data()
        let handler = session.upload(data, with: request)
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
