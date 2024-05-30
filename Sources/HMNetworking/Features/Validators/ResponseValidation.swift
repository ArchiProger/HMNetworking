//
//  ResponseValidation.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

public struct ResponseValidation: HttpClientConfig {
    var handler: ResponseValidator
    
    public init(handler: @escaping ResponseValidator) {
        self.handler = handler
    }
    
    public func process(response: HttpResponse) async throws -> HttpResponse {
        try await handler(response)
    }
}
