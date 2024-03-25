//
//  HttpBody.swift
//
//
//  Created by Archibbald on 25.03.2024.
//

import Foundation
import os.log

struct HttpBody: HttpRequestPreference {
    var data: Data?
    
    init(data: Data) {
        self.data = data
    }
    
    init(json: [String : Any]) {
        do {
            self.data = try JSONSerialization.data(withJSONObject: json)
        } catch {
            if #available(macOS 11.0, *) {
                os_log(.error, "\(error)")
            } else {
                print(error)
            }
        }
    }
    
    init<Data: Encodable>(encodable: Data) {
        do {
            self.data = try JSONEncoder().encode(encodable)
        } catch {
            if #available(macOS 11.0, *) {
                os_log(.error, "\(error)")
            } else {
                print(error)
            }
        }
    }
    
    func prepare(request: URLRequest) -> URLRequest {
        var request = request
        request.httpBody = data
        
        return request
    }
}
