//
//  PluginType.swift
//
//
//  Created by Archibbald on 25.03.2024.
//

import Foundation
import Alamofire

protocol PluginType {
    func prepare(request: DataRequest) -> DataRequest
}

extension PluginType {
    func prepare(request: DataRequest) -> DataRequest { request }
}

extension DataRequest {
    func apply(plugins: [PluginType]) -> DataRequest {
        var request: DataRequest = self
        plugins.forEach { plugin in
            request = plugin.prepare(request: request)
        }
        
        return request
    }
}
