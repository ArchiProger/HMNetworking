//
//  HttpHeaders.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

public struct HttpHeaders: HttpRequestPreference, HttpDefaultRequestPreference {
    @HttpHeadersBuilder var builder: () -> HTTPHeaders
    
    public init(@HttpHeadersBuilder builder: @escaping () -> HTTPHeaders) {
        self.builder = builder
    }
    
    public func prepare(request: URLRequest) -> URLRequest {
        var request = request
        request.headers = builder()
        
        return request
    }
    
    public func prepare(request: DefaultRequest) -> DefaultRequest {
        var request = request
        request.headers = builder()
        
        return request
    }
}
