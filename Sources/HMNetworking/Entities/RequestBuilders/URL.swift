//
//  HttpURL.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

struct URL: HttpRequestType {
    var url: URLConvertible
    
    init(_ url: URLConvertible) {
        self.url = url
    }
    
    init(domain: String, path: String) {
        self.url = domain + path
    }
    
    init(domain: String, path: String, @QueryBuilder query: () -> String) {                
        self.url = domain + path + query()
    }
    
    func prepare(request: URLRequest) -> URLRequest {
        var request = request
        request.url = try? url.asURL()
        
        return request
    }
}
