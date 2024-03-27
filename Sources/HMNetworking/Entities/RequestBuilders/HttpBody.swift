//
//  HttpBody.swift
//
//
//  Created by Archibbald on 25.03.2024.
//

import Foundation

public struct HttpBody: HttpRequestPreference {
    var data: Data?
    
    public init(data: Data) {
        self.data = data
    }
    
    public init(json: [String : Any]) {
        do {
            self.data = try JSONSerialization.data(withJSONObject: json)
        } catch {
            Logger.log(.error, error: error)
        }
    }
    
    public init<Data: Encodable>(encodable: Data) {
        do {
            self.data = try JSONEncoder().encode(encodable)
        } catch {
            Logger.log(.error, error: error)
        }
    }
    
    public func prepare(request: URLRequest) -> URLRequest {
        var request = request
        request.httpBody = data
        
        return request
    }
}
