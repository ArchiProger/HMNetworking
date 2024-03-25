import XCTest
@testable import HMNetworking

final class HMNetworkingTests: XCTestCase {
    let client = HttpClient()
    
    func testExample() async throws {
        let response = try await client.request("https://jsonplaceholder.typicode.com/comments") {
            Query {
                Parameter(name: "postid", body: "1")
            }
            
            HttpHeaders {
                Header(.defaultUserAgent)
                Header(name: "content-type", value: "application/json")
            }
        }
        
        print(String(data: response.data!, encoding: .utf8))                
    }
}
