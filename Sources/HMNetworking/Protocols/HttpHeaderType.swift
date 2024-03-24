//
//  HttpHeaderType.swift
//
//
//  Created by Archibbald on 24.03.2024.
//

import Foundation
import Alamofire

protocol HttpHeaderType {
    func prepare(headers: HTTPHeaders) -> HTTPHeaders
}
