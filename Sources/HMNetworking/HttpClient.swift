//
//  HttpClient.swift
//
//
//  Created by Артур Данилов on 08.01.2024.
//

import Foundation
import Alamofire

public struct HttpClient {
    var defaultRequest = DefaultRequest()
    var defaultPlugins: [PluginType] = []
    
    public init(
        @HttpPluginsBuilder plugins: () -> [PluginType] = { [] },
        @HttpDefaultRequestBuilder preferences: () -> [HttpDefaultRequestPreference]
    ) {
        defaultRequest = defaultRequest.apply(preferences: preferences())
        defaultPlugins = plugins()
    }
    
    public init(
        @HttpPluginsBuilder plugins: () -> [PluginType] = { [] }
    ) {
        self.init(plugins: plugins, preferences: { })
    }
    
    // MARK: - Basic requests
    public func request(_ convertible: URLConvertible,
                 session: Session = AF,
                 @HttpPluginsBuilder plugins: () -> [PluginType] = { [] }
    ) async throws -> AFDataResponse<Data?> {
        try await request(convertible, session: session, plugins: plugins, preferences: { })
    }
    
    public func request(_ convertible: URLConvertible,
                 session: Session = AF,
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
}
