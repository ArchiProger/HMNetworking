//
//  HttpHeaderType.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

public protocol HttpHeaderType: Sendable {
    var header: HTTPHeader { get }
}
