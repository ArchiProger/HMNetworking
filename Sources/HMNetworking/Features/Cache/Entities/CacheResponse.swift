//
//  CacheResponse.swift
//  HMNetworking
//
//  Created by Archibbald on 15.07.2024.
//

import Foundation

struct CacheResponse: ResponseValidatorType {
    var cache: URLCache
    
    func execute(for response: HttpResponse) async throws -> HttpResponse {
        let request = response.request.urlRequest
        let data = try? response.data
        let httpResponse = response.httpResponse
        
        guard let data, let httpResponse else { return response }
        
        let cachedURLResponse = CachedURLResponse(response: httpResponse, data: data, storagePolicy: .allowed)
        
        cache.storeCachedResponse(cachedURLResponse, for: request)
        
        return response
    }
}
