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

public extension [HttpClientConfig] {
    var request: HttpRequest {
        var request = HttpRequest.empty
        
        self.forEach {
            request = $0.prepare(request: request)
        }
        
        return request
    }
}
