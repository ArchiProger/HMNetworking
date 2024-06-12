//
//  HttpResponse.swift
//  HMNetworking
//
//  Created by Archibbald on 30.05.2024.
//

import Foundation
import Alamofire

public struct HttpResponse: Sendable {
    /// The URL request sent to the server.
    public let request: HttpRequest

    /// The server's response to the URL request.
    public let statusCode: Int

    /// The final metrics of the response.
    ///
    /// - Note: Due to `FB7624529`, collection of `URLSessionTaskMetrics` on watchOS is currently disabled.`
    ///
    public let metrics: URLSessionTaskMetrics?

    /// The time taken to serialize the response.
    public let serializationDuration: TimeInterval
    
    /// The result of response serialization.
    public let result: Result<Data?, Error>
    
    init(from response: AFDataResponse<Data?>, with request: HttpRequest) {
        self.request = request
        self.result = response.result.mapError { $0 as Error }
        self.statusCode = response.response?.statusCode ?? 200
        self.metrics = response.metrics
        self.serializationDuration = response.serializationDuration
    }
}

// MARK: - Public methods
public extension HttpResponse {
    /// The data returned by the server.
    var data: Data {
        get throws {
            try result.get() ?? Data()
        }
    }
    
    func bodyAsText(encoding: String.Encoding = .utf8) throws -> String {
        try String(data: data, encoding: encoding) ?? ""
    }
    
    func body<T: Decodable>(decoder: JSONDecoder = .init()) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}
