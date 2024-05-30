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
        let text = query.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed)
        let host = request.url?.absoluteString
        
        if let text, let host {
            var request = request
            request.url = .init(string: host + text)
        }
        
        return request
    }
}
