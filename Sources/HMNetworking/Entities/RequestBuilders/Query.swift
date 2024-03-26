//
//  HttpURL.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

public struct Query: HttpRequestPreference {
    var url: String
    
    public init(@QueryBuilder parameters: () -> String) {
        self.url = parameters()
    }
    
    public func prepare(request: URLRequest) -> URLRequest {
        let base = request.url?.absoluteString ?? ""
        let url = base + url
        
        var request = request
        request.url = .init(string: url)
        
        return request
    }
}
