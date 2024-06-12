//
//  ResponseValidation.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

public struct ResponseValidation: HttpClientConfig {
    var validator: ResponseValidator.Validator
    
    public init(validator: @escaping ResponseValidator.Validator) {
        self.validator = validator
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        var request = request
        request.validators.append(ResponseValidator(validator))
        
        return request
    }
}

public struct ResponseValidator: ResponseValidatorType {
    public typealias Validator = @Sendable (HttpResponse) async throws -> HttpResponse
    
    let validator: Validator
    
    public init(_ validator: @escaping Validator) {
        self.validator = validator
    }
    
    public func execute(for response: HttpResponse) async throws -> HttpResponse {
        try await validator(response)
    }
}
