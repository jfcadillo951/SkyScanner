//
//  Carrier.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

struct Carrier: Codable {
    let id: Int
    let code: String
    let name: String
    let imageUrl: String
    let displayCode: String

    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case code = "Code"
        case name = "Name"
        case imageUrl = "ImageUrl"
        case displayCode = "DisplayCode"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        code = try container.decode(String.self, forKey: .code)
        name = try container.decode(String.self, forKey: .name)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        displayCode = try container.decode(String.self, forKey: .displayCode)
    }
}
