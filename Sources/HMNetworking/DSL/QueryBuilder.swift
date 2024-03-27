//
//  QueryBuilder.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation

@resultBuilder
public final class QueryBuilder {
    public static func buildBlock(_ components: Parameter...) -> String {
        let query = components
            .compactMap { parameter in
                guard let body = parameter.body else { return nil }
                
                return "\(parameter.name)=\(body)"
            }
            .joined(separator: "&")
        
        return components.isEmpty ? "" : "?" + query
    }
}
