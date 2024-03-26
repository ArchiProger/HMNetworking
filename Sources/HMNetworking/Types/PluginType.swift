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
