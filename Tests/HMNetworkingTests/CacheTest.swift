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

struct CacheTest {
    let cache = URLCache(
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
        
    @Test func standardCaching() async throws {
        let response = try await client.request("/comments") {
            Query {
                Parameter(name: "postid", body: "1")
            }
            
            Cache()
                .shouldCache { _ in true }
                .shouldReturnCache { _ in true }
        }
                        
        let cache = URLCache.shared.cachedResponse(for: response.request.urlRequest)
        
        #expect(cache != nil)
    }
    
    @Test func customCaching() async throws {
        let response = try await client.request("/posts/1") {
            Cache(cache: cache)
                .shouldCache { _ in true }
                .shouldReturnCache { _ in true }
        }
        
//        let _ : PostDTO = try response.body()
        let request = response.request.urlRequest
        let cachedURLResponse = cache.cachedResponse(for: request)
                        
        #expect(response.fetchType == .cache)
        #expect(cachedURLResponse != nil)
        #expect(response.request.configuration.urlCache == cache)
    }
}
