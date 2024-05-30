//
//  HttpRequestTests.swift
//  HMNetworking
//
//  Created by Archibbald on 30.05.2024.
//

import XCTest
@testable import HMNetworking

final class HttpRequestTests: XCTestCase {
    func testEmptyURL() async throws {
        let client = HttpClient {
            Host("Hello, World")
            HttpHeaders {
                
            }
        }
    }
}
