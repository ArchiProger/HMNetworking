//
//  HttpURL.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

struct Query: HttpRequestPreference {
    var url: String
    
    init(@QueryBuilder parameters: () -> String) {
        self.url = parameters()
    }
    
    func prepare(request: URLRequest) -> URLRequest {
        let base = request.url?.absoluteString ?? ""
        let url = base + url
        
        var request = request
        request.url = .init(string: url)
        
        return request
    }
}
