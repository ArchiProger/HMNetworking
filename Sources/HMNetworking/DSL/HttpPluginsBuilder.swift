//
//  HttpPluginsBuilder.swift
//
//
//  Created by Archibbald on 25.03.2024.
//

import Foundation

@resultBuilder
public final class HttpPluginsBuilder {
    public static func buildBlock(_ components: [PluginType]...) -> [PluginType] {
        components.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: PluginType) -> [PluginType] {
        [expression]
    }
    
    public static func buildEither(first component: [PluginType]) -> [PluginType] {
        component
    }
    
    public static func buildEither(second component: [PluginType]) -> [PluginType] {
        component
    }
    
    public static func buildOptional(_ component: [PluginType]?) -> [PluginType] {
        component ?? []
    }
}
