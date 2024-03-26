//
//  Host.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation
import Alamofire

public struct Host: HttpDefaultRequestPreference {
    var url: URLConvertible
    
    public init(_ url: URLConvertible) {
        self.url = url
    }
    
    public func prepare(request: DefaultRequest) -> DefaultRequest {
        var request = request
        request.host = url
        
        return request
    }
}
