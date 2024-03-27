//
//  PluginType.swift
//
//
//  Created by Archibbald on 25.03.2024.
//

import Foundation
import Alamofire

public protocol PluginType {
    func prepare<T: Request>(request: T) -> T
}

public extension PluginType {
    func prepare(request: Request) -> Request { request }
}

extension [PluginType]: PluginType {
    public func prepare<T>(request: T) -> T where T : Request {
        var request = request
        
        self.forEach { plugin in
            request = plugin.prepare(request: request)
        }
        
        return request
    }
}
