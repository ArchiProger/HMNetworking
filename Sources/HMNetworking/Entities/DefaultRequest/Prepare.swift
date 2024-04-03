//
//  Prepare.swift
//  HMNetworking
//
//  Created by Archibbald on 03.04.2024.
//

import Foundation

public struct Prepare: HttpDefaultRequestPreference {
    var perform: PreparePerform
    
    public init(perform: @escaping PreparePerform) {
        self.perform = perform
    }
    
    public func prepare(request: DefaultRequest) -> DefaultRequest {
        var request = request
        request.prepare = perform
        
        return request
    }
}
