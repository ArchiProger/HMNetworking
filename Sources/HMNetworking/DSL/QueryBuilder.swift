//
//  QueryBuilder.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation

@resultBuilder
public final class QueryBuilder {
    public static func buildBlock(_ components: [Parameter]...) -> [Parameter] {
        components.flatMap { $0 }
    }        
    
    public static func buildExpression(_ expression: Parameter) -> [Parameter] {
        [expression]
    }
    
    public static func buildEither(first component: [Parameter]) -> [Parameter] {
        component
    }
    
    public static func buildEither(second component: [Parameter]) -> [Parameter] {
        component
    }
    
    public static func buildOptional(_ component: [Parameter]?) -> [Parameter] {
        component ?? []
    }
}
