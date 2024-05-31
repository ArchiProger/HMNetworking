//
//  RetryTests.swift
//  HMNetworking
//
//  Created by Archibbald on 31.05.2024.
//

import XCTest
import HMNetworking
import os.log

final class RetryTests: XCTestCase {
    let client = HttpClient {
        Host("https://www.google.com")
    }
    
    func testRetry() async throws {
        var retry = 0
        let response = try await client.request("/some_failure_page") {
            Retry()
                .retryIf { response in
                    retry += 1
                    
                    os_log(.fault, "\(response.request.url?.absoluteString) \(response.statusCode)")
                    
                    return !(200...299).contains(response.statusCode)
                }
                .modify { request in
                    guard retry == 1 else { return request }
                    
                    var request = request
                    request.url = .init(string: "https://www.google.com")
                    
                    return request
                }
        }
        
        XCTAssertEqual(response.statusCode, 200)
        XCTAssertEqual(retry, 2)
    }
    
    func testRetryingCount() async throws {
        var retry = 0
        let response = try await client.request("/some_failure_page") {
            Retry(maxRetries: 5)
                .retryIf { response in
                    retry += 1
                    
                    return !(200...299).contains(response.statusCode)
                }
        }
        
        XCTAssertEqual(response.statusCode, 404)
        XCTAssertEqual(retry, 5)
    }
}
