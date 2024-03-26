//
//  ResponseValidation.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

struct ResponseValidation: HttpDefaultRequestPreference {
    var handler: ResponseHandler
    
    init(handler: @escaping ResponseHandler) {
        self.handler = handler
    }
    
    func prepare(request: DefaultRequest) -> DefaultRequest {
        var request = request
        request.responseHandler = handler
        
        return request
    }
}
