//
//  CacheTest.swift
//  HMNetworking
//
//  Created by Archibbald on 15.07.2024.
//

import Testing
import Foundation
import os.log
@testable import HMNetworking

final class LoggedCache: URLCache, @unchecked Sendable {
    override func cachedResponse(for dataTask: URLSessionDataTask) async -> CachedURLResponse? {
        os_log(.debug, "The data has been extracted")
        
        return await super.cachedResponse(for: dataTask)
    }
}

struct CacheTest {
    let cache = LoggedCache(
        memoryCapacity: 4 * 1024 * 1024,  // 4 МБ
        diskCapacity: 100 * 1024 * 1024,  // 100 МБ
        diskPath: "custom-cache"
    )
    
    let client = HttpClient {
        Host("https://jsonplaceholder.typicode.com")
        HttpHeaders {
            ContentType.applicationJson
            UserAgent.default
        }
    }
    
    init() {
        URLCache.shared.removeAllCachedResponses()
        cache.removeAllCachedResponses()
    }
        
    @Test func standardCaching() async throws {
        let response = try await client.request("/comments") {
            Query {
                Parameter(name: "postid", body: "1")
            }
            
            Cache()
        }
                        
        let cache = URLCache.shared.cachedResponse(for: response.request.urlRequest)
        
        #expect(cache != nil)
    }
    
    @Test func customCaching() async throws {
        let policy: NSURLRequest.CachePolicy = .returnCacheDataDontLoad
        let response = try await client.request("/posts/1") {
            Cache()
                .storage(cache)
                .policy(policy)
        }
        
//        let _ : PostDTO = try response.body()
        let request = response.request.urlRequest
        let cachedURLResponse = cache.cachedResponse(for: request)
        let fetchType = response.metrics?.transactionMetrics.last?.resourceFetchType
                        
        #expect(fetchType == .localCache)
        #expect(cachedURLResponse != nil)
        #expect(request.cachePolicy == policy)
        #expect(response.request.configuration.urlCache == cache)
        #expect(response.request.configuration.requestCachePolicy == policy)
    }
}
