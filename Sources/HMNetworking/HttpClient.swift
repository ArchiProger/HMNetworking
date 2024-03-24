//
//  HttpClient.swift
//  
//
//  Created by Артур Данилов on 08.01.2024.
//

import Foundation
import Alamofire

struct HttpClient {
    func request(@HttpRequestBuilder builder: () -> URLRequest) async throws -> AFDataResponse<Data?> {
        let request = builder()
        
        return await AF.request(request)
            .response()
    }
}
