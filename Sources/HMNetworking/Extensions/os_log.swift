//
//  os_log.swift
//  HMNetworking
//
//  Created by Archibbald on 27.03.2024.
//

import Foundation
import os.log

struct Logger {
    static func log(_ logLevel: OSLogType = .default, error: Error) {
        if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
            os_log(.error, "\(error)")
        } else {
            print(error)
        }
    }
}
