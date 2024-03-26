//
//  HttpHeader.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

public struct Header: HttpHeaderType {
    public var header: HTTPHeader
    
    public init(_ header: HTTPHeader) {
        self.header = header
    }
    
    public init(name: String, value: String) {
        self.header = .init(name: name, value: value)
    }
}
