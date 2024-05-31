//
//  RequestMode.swift
//  HMNetworking
//
//  Created by Archibbald on 31.05.2024.
//

import Foundation

public struct RequestMode: HttpClientConfig {
    var mode: Mode
    
    public init(_ mode: Mode) {
        self.mode = mode
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        var request = request
        request.mode = mode
        
        return request
    }
}

public extension RequestMode {
    enum Mode {
        case request
        case upload
    }
}
