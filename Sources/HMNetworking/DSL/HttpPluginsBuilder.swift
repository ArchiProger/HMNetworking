//
//  HttpPluginsBuilder.swift
//
//
//  Created by Archibbald on 25.03.2024.
//

import Foundation

@resultBuilder
final class HttpPluginsBuilder {
    static func buildBlock(_ components: PluginType...) -> [PluginType] {
        components
    }
}
