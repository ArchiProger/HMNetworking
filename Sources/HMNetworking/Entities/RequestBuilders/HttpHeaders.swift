//
//  HttpHeaders.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

struct HttpHeaders: HttpRequestPreference, HttpDefaultRequestPreference {
    @HttpHeadersBuilder var builder: () -> HTTPHeaders
    
    func prepare(request: URLRequest) -> URLRequest {
        var request = request
        request.headers = builder()
        
        return request
    }
    
    func prepare(request: DefaultRequest) -> DefaultRequest {
        var request = request
        request.headers = builder()
        
        return request
    }
}
