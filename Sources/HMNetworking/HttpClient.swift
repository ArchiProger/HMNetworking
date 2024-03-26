//
//  HttpClient.swift
//
//
//  Created by Артур Данилов on 08.01.2024.
//

import Foundation
import Alamofire

struct HttpClient {
    var defaultRequest = DefaultRequest()
    
    public init(@HttpDefaultRequestBuilder preferences: () -> [HttpDefaultRequestPreference] = { [] }) {
        defaultRequest = defaultRequest.apply(preferences: preferences())
    }
    
    func request(_ convertible: URLConvertible,
                 session: Session = AF,
                 @HttpPluginsBuilder plugins: () -> [PluginType] = { [] }
    ) async throws -> AFDataResponse<Data?> {
        try await request(convertible, session: session, plugins: plugins, preferences: { })
    }
    
    func request(_ convertible: URLConvertible,
                 session: Session = AF,
                 @HttpPluginsBuilder plugins: () -> [PluginType] = { [] },
                 @HttpRequestBuilder preferences: () -> [HttpRequestPreference]
    ) async throws -> AFDataResponse<Data?> {
        
        let url = defaultRequest.host + convertible
        let request = try URLRequest(url: url, method: .get, headers: defaultRequest.headers)
            .apply(preferences: preferences())
        
        let handler = session.request(request)
        
        let response = await handler
            .apply(plugins: plugins())
            .response()
        
        return try defaultRequest.responseHandler(response)
    }
}
