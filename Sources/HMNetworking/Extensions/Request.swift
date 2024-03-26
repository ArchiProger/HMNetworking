//
//  Request.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation
import Alamofire

extension Request {
    func apply(plugins: [any PluginType]) -> Self {
        var request = self
        plugins.forEach { plugin in
            request = plugin.prepare(request: request)
        }
        
        return request
    }    
}
