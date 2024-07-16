//
//  HttpCache.swift
//  HMNetworking
//
//  Created by Archibbald on 16.07.2024.
//

import Foundation

struct HttpCache {
    var cache: URLCache = .shared
    var shouldCache: CachingCondition = { _ in false }
    var shouldReturnCachedResult: CachedResultCondition = { _ in false }
    
    func save(_ response: HttpResponse) {
        guard shouldCache(response) else { return }
        
        let request = response.request.urlRequest
        let data = (try? response.data) ?? Data()
        let httpResponse = response.httpResponse
        
        guard let httpResponse else { return }
        
        let cachedURLResponse = CachedURLResponse(response: httpResponse, data: data, storagePolicy: .allowed)
        
        cache.storeCachedResponse(cachedURLResponse, for: request)
    }
    
    func cachedResponse(for request: HttpRequest) -> HttpResponse? {
        guard shouldReturnCachedResult(request) else { return nil }
        
        let urlRequest = request.urlRequest
        let cachedResponse = cache.cachedResponse(for: urlRequest)
        
        guard let cachedResponse else { return nil }
        
        return .init(from: cachedResponse, with: request)
    }
}
