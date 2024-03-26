//
//  HttpDefaultRequestBuilder.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

@resultBuilder
public final class HttpDefaultRequestBuilder {
    public static func buildBlock(_ components: HttpDefaultRequestPreference...) -> [HttpDefaultRequestPreference] {
        components
    }    
}
