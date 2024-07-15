//
//  Cache.swift
//  HMNetworking
//
//  Created by Archibbald on 15.07.2024.
//

import Foundation

public typealias CachingCondition = @Sendable (HttpRequest) -> Bool
public typealias CachedResultCondition = @Sendable (HttpResponse) -> Bool

public struct Cache: HttpClientConfig, ResponseValidatorType {
    var cache: URLCache
    var shouldCache: CachingCondition = { _ in false }
    var shouldReturnCachedResult: CachedResultCondition = { _ in false }
    
    public init(cache: URLCache = .shared) {
        self.cache = cache
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        var configuration = request.configuration
        configuration.urlCache = cache
        
        var request = request
        request.configuration = configuration
        request.validators.append(self)
        
        return request
    }
    
    public func execute(for response: HttpResponse) async throws -> HttpResponse {
        let request = response.request.urlRequest
        let data = (try? response.data) ?? Data()
        let httpResponse = response.httpResponse
        
        guard let httpResponse else { return response }
        
        let cachedURLResponse = CachedURLResponse(response: httpResponse, data: data, storagePolicy: .allowed)
        
        cache.storeCachedResponse(cachedURLResponse, for: request)
        
        return response
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
