//
//  HttpDefaultRequestPreference.swift
//
//
//  Created by Archibbald on 26.03.2024.
//

import Foundation

public protocol HttpDefaultRequestPreference {
    func prepare(request: DefaultRequest) -> DefaultRequest
}
