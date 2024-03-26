//
//  Networking.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

public extension AFDataResponse<Data?> {
    func body<T: Decodable>(decoder: JSONDecoder = JSONDecoder()) throws -> T {
        let data = try result.get() ?? Data()
        
        return try decoder.decode(T.self, from: data)
    }
}
