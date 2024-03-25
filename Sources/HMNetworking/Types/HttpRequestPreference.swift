//
//  HttpRequestPreference.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

protocol HttpRequestPreference {
    func prepare(request: URLRequest) -> URLRequest
}

extension URLRequest {
    func apply(preferences: [HttpRequestPreference]) -> URLRequest {
        var request: URLRequest = self
        preferences.forEach { preference in
            request = preference.prepare(request: request)
        }
        
        return request
    }
}
