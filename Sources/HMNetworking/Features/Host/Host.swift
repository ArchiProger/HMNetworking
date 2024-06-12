//
//  Host.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation
import Alamofire

public struct Host<Convertible: URLConvertible & Sendable>: HttpClientConfig {
    var url: Convertible
    
    public init(_ url: Convertible) {
        self.url = url
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        var request = request
        request.url = try? url.asURL()
        
        return request
    }
}
