//
//  FormDataBody.swift
//  HMNetworking
//
//  Created by Archibbald on 31.05.2024.
//

import Foundation

public struct FormDataBody: HttpClientConfig {
    var preferences: [FormData]
    
    public init(@FormDataBuilder data: () -> [FormData]) {
        self.preferences = data()
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        for preference in preferences {
            preference.perform(request.formData)
        }
        
        return request
    }
}
