//
//  ResponseValidatorType.swift
//  HMNetworking
//
//  Created by Archibbald on 12.06.2024.
//

import Foundation

public protocol ResponseValidatorType: Sendable {
    @Sendable
    func execute(for response: HttpResponse) async throws -> HttpResponse
}
