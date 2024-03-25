//
//  SerializationTest.swift
//  
//
//  Created by Archibbald on 25.03.2024.
//

import XCTest
@testable import HMNetworking

fileprivate struct PostDTO: Codable {
    var id: Int? = nil
    var title: String
    var body: String
    var userId: Int
}

final class SerializationTests: XCTestCase {
    private let client = HttpClient()
    private let post = PostDTO(title: "Data", body: "data serializer", userId: 1)
    
    func testDataSerialization() async throws {
        let data = try JSONEncoder().encode(post)
        
        let response = try await client.request("https://jsonplaceholder.typicode.com/posts") {
            HttpMethod(.post)
            HttpBody(data: data)
            
            HttpHeaders {
                Header(.contentType("application/json; charset=UTF-8"))
            }
        }
        
        XCTAssertEqual(response.response?.statusCode, 201)
    }
    
    func testJSONSerialization() async throws {
        let post: [String : Any] = [
            "title": "Data",
            "body": "data serializer",
            "userId": 1
        ]
        
        let response = try await client.request("https://jsonplaceholder.typicode.com/posts") {
            HttpMethod(.post)
            HttpBody(json: post)
            
            HttpHeaders {
                Header(.contentType("application/json; charset=UTF-8"))
            }
        }
        
        XCTAssertEqual(response.response?.statusCode, 201)
    }
    
    func testEncodableSerialization() async throws {
        let response = try await client.request("https://jsonplaceholder.typicode.com/posts") {
            HttpMethod(.post)
            HttpBody(encodable: self.post)
            
            HttpHeaders {
                Header(.contentType("application/json; charset=UTF-8"))
            }
        }
        
        XCTAssertEqual(response.response?.statusCode, 201)
    }
    
    func testDeserialization() async throws {
        let response = try await client.request("https://jsonplaceholder.typicode.com/posts") {
            HttpMethod(.post)
            HttpBody(encodable: self.post)
            
            HttpHeaders {
                Header(.contentType("application/json; charset=UTF-8"))                
            }
        }
        
        let post: PostDTO = try response.body()
        
        XCTAssertNotNil(post.id)
    }
}
