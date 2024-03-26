//
//  URLConvertible.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation
import Alamofire

func +(lhs: URLConvertible, rhs: URLConvertible) -> URLConvertible {
    let lhs = (try? lhs.asURL().absoluteString) ?? ""
    let rhs = (try? rhs.asURL().absoluteString) ?? ""
    
    return lhs + rhs
}
