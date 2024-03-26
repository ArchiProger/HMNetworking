//
//  HttpRequestBuilder.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

@resultBuilder
public final class HttpRequestBuilder {
    public static func buildBlock(_ components: HttpRequestPreference...) -> [HttpRequestPreference] {
        components
    }
}
