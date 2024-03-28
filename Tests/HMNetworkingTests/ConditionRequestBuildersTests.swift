//
//  ConditionRequestBuildersTests.swift
//  HMNetworking
//
//  Created by Archibbald on 28.03.2024.
//

import XCTest
@testable import HMNetworking

final class ConditionRequestBuildersTests: XCTestCase {
    func testRequestBuilder() async throws {
        let condition = false
        let preferences = buildPreferences(condition)
        let request = try URLRequest(url: "https://jsonplaceholder.typicode.com", method: .get)
            .apply(preferences: preferences)
            
        XCTAssertEqual(request.method, condition ? .post : .get)
        XCTAssertEqual(request.headers.isEmpty, !condition)
        XCTAssertEqual(request.httpBody?.isEmpty ?? true, !condition)
    }
    
    func testQuery() async throws {
        let condition = true
        let parameters = buildQuery(condition)
        
        XCTAssertEqual(parameters.isEmpty, !condition)
    }
}

extension ConditionRequestBuildersTests {
    @HttpRequestBuilder
    func buildPreferences(_ condition: Bool) -> [HttpRequestPreference] {
        if condition {
            HttpMethod(.post)
            HttpBody(json: [
                "title": "Data",
                "body": "data serializer",
                "userId": 1
            ])
            
            HttpHeaders {
                Header(.contentType("application/json"))
            }
        }
    }
    
    @QueryBuilder
    func buildQuery(_ condition: Bool) -> [Parameter] {
        if condition {
            Parameter(name: "name", body: "body")
        }
    }
}
