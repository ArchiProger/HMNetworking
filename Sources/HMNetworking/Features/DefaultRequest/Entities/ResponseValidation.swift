//
//  ResponseValidation.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

public struct ResponseValidation: HttpClientConfig {
    var handler: ResponseHandler
    
    public init(handler: @escaping ResponseHandler) {
        self.handler = handler
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        var request = request
        
        return request
    }
}
