//
//  DefaultRequest.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation
import Alamofire

public typealias ResponseHandler = (AFDataResponse<Data?>) throws -> AFDataResponse<Data?>
public typealias PreparePerform = (URLRequest) throws -> URLRequest

public struct DefaultRequest {
    public var host: URLConvertible = ""
    public var headers: HTTPHeaders = []
    public var responseHandler: ResponseHandler = { $0 }    
    public var prepare: PreparePerform = { $0 }
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
