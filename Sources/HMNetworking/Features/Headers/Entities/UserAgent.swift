//
//  UserAgent.swift
//  HMNetworking
//
//  Created by Archibbald on 15.07.2024.
//

import Foundation
import Alamofire

public struct UserAgent: HttpHeaderType {
    public var header: HTTPHeader
    
    public init(_ value: String) {
        self.header = .userAgent(value)
    }
}

public extension UserAgent {
    static let `default` = Header(.defaultUserAgent)
}
