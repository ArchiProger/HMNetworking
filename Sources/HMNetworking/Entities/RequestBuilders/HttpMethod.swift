//
//  HttpMethod.swift
//
//
//  Created by Archibbald on 25.03.2024.
//

import Foundation
import Alamofire

public struct HttpMethod: HttpRequestPreference {
    var method: HTTPMethod
    
    public init(_ method: HTTPMethod) {
        self.method = method
    }
    
    public func prepare(request: URLRequest) -> URLRequest {
        var request = request
        request.method = method
        
        return request
    }
}
