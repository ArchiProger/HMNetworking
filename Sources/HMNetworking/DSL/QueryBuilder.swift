//
//  QueryBuilder.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation

@resultBuilder
final class QueryBuilder {
    static func buildBlock(_ components: Parameter...) -> String {
        let query = components.map { "\($0.name)=\($0.body)" }.joined(separator: "&")
        
        return components.isEmpty ? "" : "?" + query
    }
}
