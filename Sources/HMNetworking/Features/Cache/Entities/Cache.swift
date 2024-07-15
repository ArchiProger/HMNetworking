//
//  Cache.swift
//  HMNetworking
//
//  Created by Archibbald on 15.07.2024.
//

import Foundation

public struct Cache: HttpClientConfig {
    var cache: URLCache? = nil
    var policy: NSURLRequest.CachePolicy = .useProtocolCachePolicy
    
    public init() { }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        var configuration = request.configuration
        configuration.urlCache = cache
        configuration.requestCachePolicy = policy
        
        var request = request
        request.cachePolicy = policy
        request.configuration = configuration
        request.validators.append(CacheResponse(cache: cache ?? URLCache.shared))
        
        return request
    }
}

public extension Cache {
    func storage(_ cashe: URLCache) -> Self {
        var modifier = self
        modifier.cache = cashe
        
        return modifier
    }
    
    func policy(_ policy: NSURLRequest.CachePolicy) -> Self {
        var modifier = self
        modifier.policy = policy
        
        return modifier
    }
}
