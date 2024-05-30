//
//  HttpHeaders.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

public struct HttpHeaders: HttpClientConfig {
    var headers: [HttpHeaderType]
    
    public init(@HttpHeadersBuilder headers: @escaping () -> [HttpHeaderType]) {
        self.headers = headers()
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        var request = request
        headers.forEach {
            request.headers.add($0.header)
        }
        
        return request
    }
}
