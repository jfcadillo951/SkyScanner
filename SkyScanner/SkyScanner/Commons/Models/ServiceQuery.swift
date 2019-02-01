//
//  ServiceQuery.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

struct ServiceQuery: Codable {
    let dateTime: String

    private enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try container.decode(String.self, forKey: .dateTime)
    }
}
