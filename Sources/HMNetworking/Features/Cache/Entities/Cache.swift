//
//  Cache.swift
//  HMNetworking
//
//  Created by Archibbald on 15.07.2024.
//

import Foundation

public typealias CachingCondition = @Sendable (HttpResponse) -> Bool
public typealias CachedResultCondition = @Sendable (HttpRequest) -> Bool

public struct Cache: HttpClientConfig {
    var cache: URLCache
    var shouldCache: CachingCondition = { _ in false }
    var shouldReturnCachedResult: CachedResultCondition = { _ in false }
    
    public init(cache: URLCache = .shared) {
        self.cache = cache
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        let configuration = request.configuration
        configuration.urlCache = cache
        
        var request = request
        request.configuration = configuration
        request.cache = HttpCache(
            cache: cache,
            shouldCache: shouldCache,
            shouldReturnCachedResult: shouldReturnCachedResult
        )
        
        return request
    }
}

public extension Cache {
    func shouldCache(perform: @escaping CachingCondition) -> Self {
        var modifier = self
        modifier.shouldCache = perform
        
        return modifier
    }
    
    func shouldReturnCache(perform: @escaping CachedResultCondition) -> Self {
        var modifier = self
        modifier.shouldReturnCachedResult = perform
        
        return modifier
    }
}
