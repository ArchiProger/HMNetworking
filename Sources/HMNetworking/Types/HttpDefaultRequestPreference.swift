//
//  HttpDefaultRequestPreference.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

public protocol HttpDefaultRequestPreference {
    func prepare(request: DefaultRequest) -> DefaultRequest
}

extension [HttpDefaultRequestPreference]: HttpDefaultRequestPreference {
    public func prepare(request: DefaultRequest) -> DefaultRequest {
        var request = request
        
        self.forEach { preference in
            request = preference.prepare(request: request)
        }
        
        return request
    }
}
