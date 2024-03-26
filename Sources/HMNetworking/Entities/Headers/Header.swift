//
//  HttpHeader.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

public struct Header: HttpHeaderType {
    var header: HTTPHeader
    
    public init(_ header: HTTPHeader) {
        self.header = header
    }
    
    public init(name: String, value: String) {
        self.header = .init(name: name, value: value)
    }
    
    public func prepare(headers: HTTPHeaders) -> HTTPHeaders {
        var headers = headers
        headers.add(header)
        
        return headers
    }
}
