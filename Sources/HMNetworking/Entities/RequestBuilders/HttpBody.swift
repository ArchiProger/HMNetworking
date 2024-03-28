//
//  HttpBody.swift
//
//
//  Created by Archibbald on 25.03.2024.
//

import Foundation
import Alamofire

public struct HttpBody: HttpRequestPreference {
    var data: Data?
    var header: HTTPHeader?
    
    public init(data: Data) {
        self.data = data
    }
    
    public init(json: [String : Any]) {
        do {
            self.data = try JSONSerialization.data(withJSONObject: json)
            self.header = .contentType("application/json")
        } catch {
            Logger.log(.error, error: error)
        }
    }
    
    public init<Data: Encodable>(encodable: Data) {
        do {
            self.data = try JSONEncoder().encode(encodable)
            self.header = .contentType("application/json")
        } catch {
            Logger.log(.error, error: error)
        }
    }
    
    public func prepare(request: URLRequest) -> URLRequest {
        var request = request
        request.httpBody = data
        
        if let header = header {
            request.headers.add(header)
        }
        
        return request
    }
}
