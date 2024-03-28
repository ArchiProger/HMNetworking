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
    public static func buildBlock(_ components: [HttpHeaderType]...) -> [HttpHeaderType] {
        components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: HttpHeaderType) -> [HttpHeaderType] {
        [expression]
    }
    
    public static func buildEither(first component: [HttpHeaderType]) -> [HttpHeaderType] {
        component
    }
    
    public static func buildEither(second component: [HttpHeaderType]) -> [HttpHeaderType] {
        component
    }
    
    public static func buildOptional(_ component: [HttpHeaderType]?) -> [HttpHeaderType] {
        component ?? []
    }
}
