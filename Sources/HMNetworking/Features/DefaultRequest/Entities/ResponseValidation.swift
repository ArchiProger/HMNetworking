//
//  ResponseValidation.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

public struct ResponseValidation: HttpDefaultRequestPreference {
    var handler: ResponseHandler
    
    public init(handler: @escaping ResponseHandler) {
        self.handler = handler
    }
    
    public func prepare(request: DefaultRequest) -> DefaultRequest {
        var request = request
        request.responseHandler = handler
        
        return request
    }
}
