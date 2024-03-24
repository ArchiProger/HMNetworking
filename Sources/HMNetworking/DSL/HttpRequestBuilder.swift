//
//  HttpRequestBuilder.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

@resultBuilder
final class HttpRequestBuilder {
    static func buildBlock(_ components: HttpRequestType...) -> URLRequest {
        let url = Foundation.URL(string: "https://github.com/Alamofire/Alamofire")!
        var request = URLRequest(url: url)
        
        for component in components {
            request = component.prepare(request: request)
        }
        
        return request
    }
}
