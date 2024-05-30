//
//  ValidatorsTests.swift
//  HMNetworking
//
//  Created by Archibbald on 30.05.2024.
//

import XCTest
import HMNetworking

final class ValidatorsTests: XCTestCase {
    let client = HttpClient {
        ResponseValidation { response in
            guard (200...299).contains(response.statusCode) else { throw "Unsuccessful error status" }
            
            return response
        }
    }
    
    func testValidator() async {
        do {
            _ = try await client.request("https://oneentry.cloud/orders")
            
            XCTFail("The request should have crashed with a 404 error")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Unsuccessful error status")
        }
    }
}
