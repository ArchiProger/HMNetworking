//
//  HttpRequestType.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation

protocol HttpRequestType {
    func prepare(request: URLRequest) -> URLRequest
}

/*
 let client = HttpClient()
 
 let response = client.request("https://...") {
    HttpBody(encodable: "Hello, World")
 
    HttpHeaders {
        Header("content-type", "application/json")
        Header("content-type", "application/json")
    }
 }
 */
