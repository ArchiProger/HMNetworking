//
//  HttpDefaultRequestBuilder.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

@resultBuilder
final class HttpDefaultRequestBuilder {
    static func buildBlock(_ components: HttpDefaultRequestPreference...) -> [HttpDefaultRequestPreference] {
        components
    }    
}
