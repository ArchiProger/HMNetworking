//
//  Prepare.swift
//  HMNetworking
//
//  Created by Archibbald on 03.04.2024.
//

import Foundation

public struct Prepare: HttpClientConfig {
    var perform: PreparePerform
    
    public init(perform: @escaping PreparePerform) {
        self.perform = perform
    }
    
    public func prepare(request: HttpRequest) -> HttpRequest {
        var request = request
        request.prepare = perform
        
        return request
    }
}
