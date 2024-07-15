//
//  ContentType.swift
//  HMNetworking
//
//  Created by Archibbald on 15.07.2024.
//

import Foundation
import Alamofire

public struct ContentType: HttpHeaderType {
    public var header: HTTPHeader
    
    public init(_ value: String) {
        header = .contentType(value)
    }
}

public extension ContentType {
    static let applicationJson = ContentType("application/json")
    static let applicationXml = ContentType("application/xml")
    static let textPlain = ContentType("text/plain")
    static let textHtml = ContentType("text/html")
    static let imagePng = ContentType("image/png")
    static let imageJpeg = ContentType("image/jpeg")
    static let imageGif = ContentType("image/gif")
    static let videoMp4 = ContentType("video/mp4")
    static let audioMp3 = ContentType("audio/mp3")
}
