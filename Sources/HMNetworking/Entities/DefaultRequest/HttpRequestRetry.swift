//
//  HttpRequestRetry.swift
//  HMNetworking
//
//  Created by Archibbald on 28.03.2024.
//

import Foundation

struct HttpRequestRetry {
    var limit: UInt
    var modify: (URLRequest) -> URLRequest
    var condition: () -> Bool
}
