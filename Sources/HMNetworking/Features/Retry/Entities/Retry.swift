//
//  Retry.swift
//  HMNetworking
//
//  Created by Archibbald on 31.05.2024.
//

import Foundation

public struct Retry: HttpClientConfig {
    public typealias RetryCondition = (HttpResponse) -> Bool
    public typealias RetryModifier = (HttpRequest) async throws -> HttpRequest
    
    var maxRetries: Int
    var shouldRetry: RetryCondition = { _ in false }
    var modifier: RetryModifier = { $0 }
    
    public init(maxRetries: Int = 3) {
        self.maxRetries = maxRetries
    }
    
    public func process(response: HttpResponse) async throws -> HttpResponse {
        var response = response
        
        for _ in 0..<maxRetries {
            let result = try? response.result.get()
            let shouldRetry = shouldRetry(response)
            
            guard result == nil || shouldRetry else { break }
            
            var request = try? await modifier(response.request)
            request?.validators.removeAll { $0 is Retry }
                                    
            response = (try? await request?.response) ?? response
        }
        
        return response
    }
}

// MARK: - Public modifiers
public extension Retry {
    func retryIf(should: @escaping RetryCondition) -> Self {
        var result = self
        result.shouldRetry = should
        
        return result
    }
    
    func modify(modifier: @escaping RetryModifier) -> Self {
        var result = self
        result.modifier = modifier
        
        return result
    }
}
