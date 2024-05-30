//
//  HttpResponse.swift
//  HMNetworking
//
//  Created by Archibbald on 30.05.2024.
//

import Foundation
import Alamofire

public struct HttpResponse {
    /// The URL request sent to the server.
    public let request: HttpRequest

    /// The server's response to the URL request.
    public let statusCode: Int

    /// The data returned by the server.
    public let data: Data

    /// The final metrics of the response.
    ///
    /// - Note: Due to `FB7624529`, collection of `URLSessionTaskMetrics` on watchOS is currently disabled.`
    ///
    public let metrics: URLSessionTaskMetrics?

    /// The time taken to serialize the response.
    public let serializationDuration: TimeInterval
    
    public init(from response: AFDataResponse<Data?>, with request: HttpRequest) throws {
        let data = try response.result.get()
        
        self.request = request
        self.statusCode = response.response?.statusCode ?? 200
        self.data = data ?? Data()
        self.metrics = response.metrics
        self.serializationDuration = response.serializationDuration
    }
}
