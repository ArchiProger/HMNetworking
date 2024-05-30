//
//  UnitingClientsTests.swift
//  HMNetworking
//
//  Created by Archibbald on 27.03.2024.
//

import XCTest
import HMNetworking

final class UnitingClientsTests: XCTestCase {
    var client: HttpClient!

    override func setUp() {
        let client = HttpClient {
            Host("https://jsonplaceholder.typicode.com")
        }
        
        self.client = client.copy {
            HttpHeaders {
                Header(.contentType("application/json; charset=UTF-8"))
                Header(.defaultUserAgent)
            }
        }
    }
    
    func testURL() async throws {
        let response = try await client.request("/posts") {
            HttpMethod(.post)
        }
        
        XCTAssertEqual(response.request.url?.absoluteString, "https://jsonplaceholder.typicode.com/posts")
    }
    
    func testHeaders() async throws {
        let response = try await client.request("/posts") {
            HttpMethod(.post)
        }
        
        let headers = response.request.headers
                                
        XCTAssertTrue(headers.contains(.defaultUserAgent))
        XCTAssertTrue(headers.contains(.contentType("application/json; charset=UTF-8")))
    }
}
