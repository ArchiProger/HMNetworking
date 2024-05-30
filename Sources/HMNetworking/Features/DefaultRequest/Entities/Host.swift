//
//  Host.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation
import Alamofire

public struct Host: HttpClientConfig {
    var url: URLConvertible
    
    public init(_ url: URLConvertible) {
        self.url = url
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        var request = request
        request.url = try? url.asURL()
        
        return request
    }
}
