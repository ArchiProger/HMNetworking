//
//  HttpClient.swift
//
//
//  Created by Артур Данилов on 08.01.2024.
//

import Foundation
import Alamofire

struct HttpClient {
    func request(_ convertible: URLConvertible,
                 session: Session = AF,
                 @HttpPluginsBuilder plugins: () -> [PluginType] = { [] },
                 @HttpRequestBuilder preferences: () -> [HttpRequestPreference]
    ) async throws -> AFDataResponse<Data?> {
        
        let url = try convertible.asURL()
        let request = URLRequest(url: url)
            .apply(preferences: preferences())
        
        let handler = session.request(request)
        
        return await handler
            .apply(plugins: plugins())
            .response()
    }
}
