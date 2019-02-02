//
//  StorageInMemory.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

enum InMemoryKey: String {
    case pollingUrl
}

protocol StorageInMemoryProtocol {
    func get(key: InMemoryKey) -> Any?
    func set(object: Any,for key: InMemoryKey)
}

class StorageInMemory: StorageInMemoryProtocol {

    static let shared = StorageInMemory()

    private var dict: [String: Any] = [:]

    func get(key: InMemoryKey) -> Any? {
        return dict[key.rawValue]
    }

    func set(object: Any, for key: InMemoryKey) {
        dict[key.rawValue] = object
    }

}
