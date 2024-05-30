//
//  HttpClientConfigBuilder.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

@resultBuilder
public final class HttpClientConfigBuilder {
    public static func buildBlock(_ components: [HttpClientConfig]...) -> [HttpClientConfig] {
        components.flatMap { $0 }
    }    
    
    public static func buildExpression(_ expression: HttpClientConfig) -> [HttpClientConfig] {
        [expression]
    }
    
    public static func buildEither(first component: [HttpClientConfig]) -> [HttpClientConfig] {
        component
    }
    
    public static func buildEither(second component: [HttpClientConfig]) -> [HttpClientConfig] {
        component
    }
    
    public static func buildOptional(_ component: [HttpClientConfig]?) -> [HttpClientConfig] {
        component ?? []
    }
}
