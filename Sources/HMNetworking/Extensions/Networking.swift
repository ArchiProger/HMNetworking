//
//  Networking.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

extension DataRequest {
    func response() async -> AFDataResponse<Data?> {
        await withUnsafeContinuation { continuation in
            self
                .response { response in
                    continuation.resume(returning: response)
                }
        }
    }
}

extension AFDataResponse<Data?> {
    enum ResponseError: LocalizedError {
        case dataNotFound
        
        var errorDescription: String? {
            "Failed to get data"
        }
    }
    
    func body<T: Decodable>(decoder: JSONDecoder = JSONDecoder()) throws -> T {
        guard let data = try result.get() else { throw ResponseError.dataNotFound }
        
        return try decoder.decode(T.self, from: data)
    }
}
