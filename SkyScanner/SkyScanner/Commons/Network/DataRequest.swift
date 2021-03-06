//
//  DataRequest.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import Alamofire

extension DataRequest {

    static func DecodableObjectSerializer<T: Decodable>(_ keyPath: String?, _ decoder: JSONDecoder) -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            if let error = error {
                return .failure(error)
            }
            guard let keyPath = keyPath, !keyPath.isEmpty else {
                return DataRequest.decodeToObject(decoder: decoder, response: response, data: data)
            }
            return DataRequest.decodeToObject(byKeyPath: keyPath, decoder: decoder, response: response, data: data)
        }
    }

    static func decodeToObject<T: Decodable>(decoder: JSONDecoder, response: HTTPURLResponse?, data: Data?) -> Result<T> {
        let result = Alamofire.Request.serializeResponseData(response: response, data: data, error: nil)

        switch result {
        case .success(let data):
            do {
                let object = try decoder.decode(T.self, from: data)
                return .success(object)
            } catch {
                #if DEBUG
                print ("DataRequest.decodeToObject error: \(error)")
                #endif
                return .failure(error)
            }
        case .failure(let error):
            #if DEBUG
            print ("DataRequest.decodeToObject result failure: \(error)")
            #endif
            return .failure(error)
        }
    }

    static func decodeToObject<T: Decodable>(byKeyPath keyPath: String, decoder: JSONDecoder, response: HTTPURLResponse?, data: Data?) -> Result<T> {
        let result = Alamofire.Request.serializeResponseJSON(options: [], response: response, data: data, error: nil)

        switch result {
        case .success(let json):
            if let nestedJson = (json as AnyObject).value(forKeyPath: keyPath) {
                do {
                    let data = try JSONSerialization.data(withJSONObject: nestedJson)
                    let object = try decoder.decode(T.self, from: data)
                    return .success(object)
                } catch {
                    return .failure(error)
                }
            } else {
                return .failure(AlamofireDecodableError.invalidKeyPath)
            }
        case .failure(let error): return .failure(error)
        }
    }

    /// Adds a handler to be called once the request has finished.

    /// - parameter queue:             The queue on which the completion handler is dispatched.
    /// - parameter keyPath:           The keyPath where object decoding should be performed. Default: `nil`.
    /// - parameter decoder:           The decoder that performs the decoding of JSON into semantic `Decodable` type. Default: `JSONDecoder()`.
    /// - parameter completionHandler: The code to be executed once the request has finished and the data has been mapped by `JSONDecoder`.

    /// - returns: The request.

    @discardableResult
    public func responseDecodableObject<T: Decodable>(queue: DispatchQueue? = nil, keyPath: String? = nil, decoder: JSONDecoder = JSONDecoder(), completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: DataRequest.DecodableObjectSerializer(keyPath, decoder), completionHandler: completionHandler)
    }
}

/// `AlamofireDecodableError` is the error type returned by CodableAlamofire.
///
/// - invalidKeyPath:   Returned when a nested dictionary object doesn't exist by special keyPath.
/// - emptyKeyPath:     Returned when a keyPath is empty.
public enum AlamofireDecodableError: Error {
    case invalidKeyPath
    case emptyKeyPath
    case invalidDecoder
}

extension AlamofireDecodableError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .invalidKeyPath:   return "Nested object doesn't exist by this keyPath."
        case .emptyKeyPath:     return "KeyPath can not be empty."
        case .invalidDecoder:     return "Please use a valid decoder (JSONDecoder)"
        }
    }
}
