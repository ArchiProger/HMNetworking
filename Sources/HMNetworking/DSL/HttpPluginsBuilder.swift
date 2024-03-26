//
//  HttpPluginsBuilder.swift
//
//
//  Created by Archibbald on 25.03.2024.
//

import Foundation

@resultBuilder
public final class HttpPluginsBuilder {
    public static func buildBlock(_ components: PluginType...) -> [PluginType] {
        components
    }
}
