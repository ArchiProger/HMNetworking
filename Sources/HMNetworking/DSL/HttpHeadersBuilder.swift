//
//  HttpHeadersBuilder.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

@resultBuilder
public final class HttpHeadersBuilder {
    public static func buildBlock(_ components: HttpHeaderType...) -> HTTPHeaders {
        var headers = HTTPHeaders()
        
        components.forEach { type in
            headers = type.prepare(headers: headers)
        }
        
        return headers
    }
}
