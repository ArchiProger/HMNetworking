//
//  HttpDefaultRequestPreference.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

public protocol HttpClientConfig {
    func prepare(request: HttpRequest) -> HttpRequest
}

public extension HttpClientConfig {
    func prepare(request: HttpRequest) -> HttpRequest { request }
}

public extension [HttpClientConfig] {
    func request(initial: HttpRequest = .init()) -> HttpRequest {
        var request = initial
        
        self.forEach {
            request = $0.prepare(request: request)
        }
        
        return request
    }
}
