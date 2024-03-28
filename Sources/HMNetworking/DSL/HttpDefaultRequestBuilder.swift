//
//  HttpDefaultRequestBuilder.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

@resultBuilder
public final class HttpDefaultRequestBuilder {
    public static func buildBlock(_ components: [HttpDefaultRequestPreference]...) -> [HttpDefaultRequestPreference] {
        components.flatMap { $0 }
    }    
    
    public static func buildExpression(_ expression: HttpDefaultRequestPreference) -> [HttpDefaultRequestPreference] {
        [expression]
    }
    
    public static func buildEither(first component: [HttpDefaultRequestPreference]) -> [HttpDefaultRequestPreference] {
        component
    }
    
    public static func buildEither(second component: [HttpDefaultRequestPreference]) -> [HttpDefaultRequestPreference] {
        component
    }
    
    public static func buildOptional(_ component: [HttpDefaultRequestPreference]?) -> [HttpDefaultRequestPreference] {
        component ?? []
    }
}
