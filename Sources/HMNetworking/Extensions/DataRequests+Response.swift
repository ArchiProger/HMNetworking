//
//  DataRequests+Response.swift
//
//
//  Created by Archibbald on 29.05.2024.
//

import Foundation
import Alamofire

extension AFDataResponse<Data?> {
    func apply(plugins: [PluginType]) async throws -> AFDataResponse<Data?> {
        var result: AFDataResponse<Data?> = self
        for plugin in plugins {
            result = try await plugin.process(response: result)
        }
        
        return result
    }
}

extension DataRequest {
    func response(with plugins: [PluginType]) async throws -> AFDataResponse<Data?> {
        let response = try await withCheckedThrowingContinuation { continuation in
            self
                .apply(plugins: plugins)
                .response { response in
                    continuation.resume(returning: response)
                }
        }
        
        return try await response.apply(plugins: plugins)
    }
}
