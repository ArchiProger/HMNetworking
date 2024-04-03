//
//  PrepareTests.swift
//  HMNetworking
//
//  Created by Archibbald on 03.04.2024.
//

import XCTest
import HMNetworking

final class PrepareTests: XCTestCase {
    let client = HttpClient {
        Prepare { _ in
            throw "Preparing error"
        }
    }
    
    func testPrepare() async {
        do {
            try await client.request("/path")
            
            XCTFail("Preparing doesn't work")
        } catch let error as String {
            XCTAssertEqual(error, "Preparing error")
        } catch {
            XCTFail("Unrenored error")
        }
    }
}
