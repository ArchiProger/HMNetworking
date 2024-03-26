//
//  Host.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation
import Alamofire

struct Host: HttpDefaultRequestPreference {
    var url: URLConvertible
    
    init(_ url: URLConvertible) {
        self.url = url
    }
    
    func prepare(request: DefaultRequest) -> DefaultRequest {
        var request = request
        request.host = url
        
        return request
    }
}
