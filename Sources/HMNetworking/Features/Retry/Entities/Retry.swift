//
//  Retry.swift
//  HMNetworking
//
//  Created by Archibbald on 31.05.2024.
//

import Foundation

public struct Retry: HttpClientConfig {
    var maxRetries: Int
    var shouldRetry: RetryValidator.RetryCondition = { _ in false }
    var modifier: RetryValidator.RetryModifier = { $0 }
    
    public init(maxRetries: Int = 3) {
        self.maxRetries = maxRetries
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        var request = request
        request.validators.append(
            RetryValidator(
                maxRetries: maxRetries,
                shouldRetry: shouldRetry,
                modifier: modifier
            )
        )
        
        return request
    }
}

// MARK: - Public modifiers
public extension Retry {
    func retryIf(should: @escaping RetryValidator.RetryCondition) -> Self {
        var result = self
        result.shouldRetry = should
        
        return result
    }
    
    func modify(modifier: @escaping RetryValidator.RetryModifier) -> Self {
        var result = self
        result.modifier = modifier
        
        return result
    }
}
