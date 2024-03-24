//
//  HttpHeaders.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

struct HttpHeaders: HttpRequestType {
    @HttpHeadersBuilder var builder: () -> HTTPHeaders
    
    func prepare(request: URLRequest) -> URLRequest {
        var request = request
        request.headers = builder()
        
        return request
    }
}
