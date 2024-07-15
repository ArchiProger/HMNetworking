//
//  Authorization.swift
//  HMNetworking
//
//  Created by Archibbald on 15.07.2024.
//

import Foundation
import Alamofire

public struct Authorization: HttpHeaderType {
    public var header: HTTPHeader
    
    public init(bearer token: String) {
        header = .authorization(bearerToken: token)
    }
    
    public init(_ value: String) {
        header = .authorization(value)
    }
    
    public init(username: String, password: String) {
        header = .authorization(username: username, password: password)
    }
}
