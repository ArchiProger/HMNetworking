//
//  FormDataBuilder.swift
//  HMNetworking
//
//  Created by Archibbald on 31.05.2024.
//

import Foundation

@resultBuilder
public final class FormDataBuilder {
    public static func buildBlock(_ components: [FormData]...) -> [FormData] {
        components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: FormData) -> [FormData] {
        [expression]
    }
    
    public static func buildEither(first component: [FormData]) -> [FormData] {
        component
    }
    
    public static func buildEither(second component: [FormData]) -> [FormData] {
        component
    }
    
    public static func buildOptional(_ component: [FormData]?) -> [FormData] {
        component ?? []
    }
}
