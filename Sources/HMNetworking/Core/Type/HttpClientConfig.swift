//
//  HttpDefaultRequestPreference.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

public protocol HttpClientConfig {
    func prepare(request: HttpRequest) -> HttpRequest
    func process(response: HttpResponse) async throws -> HttpResponse
}

public extension HttpClientConfig {
    func prepare(request: HttpRequest) -> HttpRequest { request }
    func process(response: HttpResponse) async throws -> HttpResponse { response }
}

public extension [HttpClientConfig] {
    func request(initial: HttpRequest = .empty) -> HttpRequest {
        var request = initial
        
        self.forEach {
            request = $0.prepare(request: request)
        }
        
        return request
    }
    
    var validators: [ResponseValidator] {
        self.map { $0.process(response:) }
    }
}
