//
//  RetryValidator.swift
//  HMNetworking
//
//  Created by Archibbald on 12.06.2024.
//

import Foundation

public struct RetryValidator: ResponseValidatorType {
    public typealias RetryCondition = (HttpResponse) -> Bool
    public typealias RetryModifier = (HttpRequest) async throws -> HttpRequest
    
    var maxRetries: Int
    nonisolated(unsafe) var shouldRetry: RetryCondition = { _ in false }
    nonisolated(unsafe) var modifier: RetryModifier = { $0 }
    
    public func execute(for response: HttpResponse) async throws -> HttpResponse {
        var response = response
        
        for _ in 0..<maxRetries {
            let result = try? response.result.get()
            let shouldRetry = shouldRetry(response)
            
            guard result == nil || shouldRetry else { break }
            
            var request = try? await modifier(response.request)
            request?.validators.removeAll { $0 is RetryValidator }
                                    
            response = (try? await request?.response) ?? response
        }
        
        return response
    }
}
