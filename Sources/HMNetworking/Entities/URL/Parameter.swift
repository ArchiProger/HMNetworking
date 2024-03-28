//
//  Parameter.swift
//  
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation

public struct Parameter {
    public var name: String
    public var body: Any?
    
    public init(name: String, body: Any?) {
        self.name = name
        self.body = body
    }
}

extension [Parameter] {
    var query: String {
        let query = self
            .compactMap { parameter in
                guard let body = parameter.body else { return nil }
                
                return "\(parameter.name)=\(body)"
            }
            .joined(separator: "&")
        
        return self.isEmpty ? "" : "?" + query
    }
}
