//
//  HttpRequestBuilder.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

@resultBuilder
public final class HttpRequestBuilder {
    public static func buildBlock(_ components: [HttpRequestPreference]...) -> [HttpRequestPreference] {
        components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: HttpRequestPreference) -> [HttpRequestPreference] {
        [ expression ]
    }
    
    public static func buildEither(first component: [HttpRequestPreference]) -> [HttpRequestPreference] {
        component
    }
    
    public static func buildEither(second component: [HttpRequestPreference]) -> [HttpRequestPreference] {
        component
    }
    
    public static func buildOptional(_ component: [HttpRequestPreference]?) -> [HttpRequestPreference] {
        component ?? []
    }
}
