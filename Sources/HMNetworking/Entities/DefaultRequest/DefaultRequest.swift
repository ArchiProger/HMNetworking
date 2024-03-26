//
//  DefaultRequest.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation
import Alamofire

typealias ResponseHandler = (AFDataResponse<Data?>) throws -> AFDataResponse<Data?>

struct DefaultRequest {
    var host: URLConvertible = ""
    var headers: HTTPHeaders = []    
    var responseHandler: ResponseHandler = { $0 }
}

extension DefaultRequest {
    func apply(preferences: [HttpDefaultRequestPreference]) -> DefaultRequest {
        var request = self
        preferences.forEach { preference in
            request = preference.prepare(request: request)
        }
        
        return request
    }
}
