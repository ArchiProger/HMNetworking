//
//  FormData.swift
//  HMNetworking
//
//  Created by Archibbald on 31.05.2024.
//

import Foundation
import Alamofire

extension InputStream: @retroactive @unchecked Sendable { }
extension OutputStream: @retroactive @unchecked Sendable { }
extension HTTPHeaders: @retroactive @unchecked Sendable { }
extension MultipartFormData: @retroactive @unchecked Sendable { }

public struct FormData: Sendable {
    var perform: @Sendable (MultipartFormData) -> Void
    
    /// Creates a body part from the data and appends it to the instance.
    ///
    /// The body part data will be encoded using the following format:
    ///
    /// - `Content-Disposition: form-data; name=#{name}; filename=#{filename}` (HTTP Header)
    /// - `Content-Type: #{mimeType}` (HTTP Header)
    /// - Encoded file data
    /// - Multipart form boundary
    ///
    /// - Parameters:
    ///   - data:     `Data` to encoding into the instance.
    ///   - name:     Name to associate with the `Data` in the `Content-Disposition` HTTP header.
    ///   - fileName: Filename to associate with the `Data` in the `Content-Disposition` HTTP header.
    ///   - mimeType: MIME type to associate with the data in the `Content-Type` HTTP header.
    public init(_ data: Data, with name: String, fileName: String? = nil, mimeType: String? = nil) {
        self.perform = {
            $0.append(data, withName: name, fileName: fileName, mimeType: mimeType)
        }
    }
    
    /// Creates a body part from the file and appends it to the instance.
    ///
    /// The body part data will be encoded using the following format:
    ///
    /// - Content-Disposition: form-data; name=#{name}; filename=#{filename} (HTTP Header)
    /// - Content-Type: #{mimeType} (HTTP Header)
    /// - Encoded file data
    /// - Multipart form boundary
    ///
    /// - Parameters:
    ///   - url:  `URL` of the file whose content will be encoded into the instance.
    ///   - name:     Name to associate with the file content in the `Content-Disposition` HTTP header.
    ///   - fileName: Filename to associate with the file content in the `Content-Disposition` HTTP header.
    ///   - mimeType: MIME type to associate with the file content in the `Content-Type` HTTP header.
    public init(_ url: URL, with name: String, fileName: String, mimeType: String) {
        self.perform = {
            $0.append(url, withName: name, fileName: fileName, mimeType: mimeType)
        }
    }
    
    /// Creates a body part from the file and appends it to the instance.
    ///
    /// The body part data will be encoded using the following format:
    ///
    /// - `Content-Disposition: form-data; name=#{name}; filename=#{generated filename}` (HTTP Header)
    /// - `Content-Type: #{generated mimeType}` (HTTP Header)
    /// - Encoded file data
    /// - Multipart form boundary
    ///
    /// The filename in the `Content-Disposition` HTTP header is generated from the last path component of the
    /// `url`. The `Content-Type` HTTP header MIME type is generated by mapping the `url` extension to the
    /// system associated MIME type.
    ///
    /// - Parameters:
    ///   - url: `URL` of the file whose content will be encoded into the instance.
    ///   - name:    Name to associate with the file content in the `Content-Disposition` HTTP header.
    public init(_ url: URL, with name: String) {
        self.perform = {
            $0.append(url, withName: name)
        }
    }
    
    /// Creates a body part with the stream, length, and headers and appends it to the instance.
    ///
    /// The body part data will be encoded using the following format:
    ///
    /// - HTTP headers
    /// - Encoded stream data
    /// - Multipart form boundary
    ///
    /// - Parameters:
    ///   - stream:  `InputStream` to encode into the instance.
    ///   - length:  Length, in bytes, of the stream.
    ///   - headers: `HTTPHeaders` for the body part.
    public init(_ stream: InputStream, with length: UInt64, headers: HTTPHeaders) {
        self.perform = {
            $0.append(stream, withLength: length, headers: headers)
        }
    }
    
    /// Creates a body part from the stream and appends it to the instance.
    ///
    /// The body part data will be encoded using the following format:
    ///
    /// - `Content-Disposition: form-data; name=#{name}; filename=#{filename}` (HTTP Header)
    /// - `Content-Type: #{mimeType}` (HTTP Header)
    /// - Encoded stream data
    /// - Multipart form boundary
    ///
    /// - Parameters:
    ///   - stream:   `InputStream` to encode into the instance.
    ///   - length:   Length, in bytes, of the stream.
    ///   - name:     Name to associate with the stream content in the `Content-Disposition` HTTP header.
    ///   - fileName: Filename to associate with the stream content in the `Content-Disposition` HTTP header.
    ///   - mimeType: MIME type to associate with the stream content in the `Content-Type` HTTP header.
    public init(
        _ stream: InputStream,
        with length: UInt64,
        name: String,
        fileName: String,
        mimeType: String
    ) {
        self.perform = {
            $0.append(stream, withLength: length, name: name, fileName: fileName, mimeType: mimeType)
        }
    }
}
