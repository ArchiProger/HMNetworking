//
//  HttpURL.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

public struct Query: HttpClientConfig {
    var query: String
    
    public init(@QueryBuilder parameters: () -> [Parameter]) {
        self.query = parameters().query
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        let base = request.url?.absoluteString ?? ""
        let url = base + query
        
        var request = request
        request.url = .init(string: url)
        
        return request
    }
}
