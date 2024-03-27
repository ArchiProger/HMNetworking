//
//  HttpRequestPreference.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

public protocol HttpRequestPreference {
    func prepare(request: URLRequest) -> URLRequest
}

extension [HttpRequestPreference]: HttpRequestPreference {
    public func prepare(request: URLRequest) -> URLRequest {
        var request = request
        
        self.forEach { preference in
            request = preference.prepare(request: request)
        }
        
        return request
    }
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
