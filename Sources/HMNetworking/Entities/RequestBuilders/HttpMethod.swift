//
//  HttpMethod.swift
//
//
//  Created by Archibbald on 25.03.2024.
//

import Foundation
import Alamofire

struct HttpMethod: HttpRequestPreference {
    var method: HTTPMethod
    
    init(_ method: HTTPMethod) {
        self.method = method
    }
    
    func prepare(request: URLRequest) -> URLRequest {
        var request = request
        request.method = method
        
        return request
    }
}
