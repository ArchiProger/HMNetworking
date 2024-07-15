//
//  SerializationTest.swift
//  
//
//  Created by Archibbald on 25.03.2024.
//

import XCTest
import HMNetworking

fileprivate struct PostDTO: Codable {
    var id: Int? = nil
    var title: String
    var body: String
    var userId: Int
}

extension String: @retroactive Error {}
extension String: @retroactive LocalizedError {
    public var errorDescription: String? { self }
}

final class SerializationTests: XCTestCase {
    private let post = PostDTO(title: "Data", body: "data serializer", userId: 1)
    private let client = HttpClient {
        Host("https://jsonplaceholder.typicode.com")
        HttpHeaders {
            Header(.contentType("application/json; charset=UTF-8"))
            Header(.defaultUserAgent)
        }
    }
    
    func testDataSerialization() async throws {
        let data = try JSONEncoder().encode(post)
        
        let response = try await client.request("/posts") {
            HttpMethod(.post)
            HttpBody(data: data)
        }
        
        XCTAssertEqual(response.statusCode, 201)
    }
    
    func testJSONSerialization() async throws {
        let response = try await client.request("/posts") {
            HttpMethod(.post)
            HttpBody(json: [
                "title": "Data",
                "body": "data serializer",
                "userId": 1
            ])
        }
        
        XCTAssertEqual(response.statusCode, 201)
    }
    
    func testEncodableSerialization() async throws {
        let response = try await client.request("/posts") {
            HttpMethod(.post)
            HttpBody(encodable: self.post)
        }
        
        XCTAssertEqual(response.statusCode, 201)
    }
    
    func testDeserialization() async throws {
        let response = try await client.request("/posts") {
            HttpMethod(.post)
            HttpBody(encodable: self.post)
        }
        
        let post: PostDTO = try response.body()
        
        XCTAssertEqual(response.statusCode, 201)
        XCTAssertNotNil(post.id)
    }
}
