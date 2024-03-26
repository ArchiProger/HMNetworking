import XCTest
@testable import HMNetworking

final class SimpleRequestsTests: XCTestCase {
    let client = HttpClient()
    
    func testRequest() async throws {
        let response = try await client.request("https://jsonplaceholder.typicode.com")
        
        XCTAssertEqual(response.response?.statusCode, 200)
    }
    
    func testQuery() async throws {
        let response = try await client.request("https://jsonplaceholder.typicode.com/comments") {
            Query {
                Parameter(name: "postid", body: "1")                
            }
        }
        
        XCTAssertEqual(response.response?.statusCode, 200)
    }
}
