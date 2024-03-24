//
//  HttpHeader.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

struct Header: HttpHeaderType {
    var header: HTTPHeader
    
    init(_ header: HTTPHeader) {
        self.header = header
    }
    
    init(name: String, value: String) {
        self.header = .init(name: name, value: value)
    }
    
    func prepare(headers: HTTPHeaders) -> HTTPHeaders {
        var headers = headers
        headers.add(header)
        
        return headers
    }
}
