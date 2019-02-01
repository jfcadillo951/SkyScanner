//
//  Place.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

struct Place: Codable {
    let id: Int
    let parentId: Int?
    let code: String
    let type: String
    let name: String

    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case parentId = "ParentId"
        case code = "Code"
        case type = "Type"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        parentId = try container.decode(Int?.self, forKey: .parentId)
        code = try container.decode(String.self, forKey: .code)
        type = try container.decode(String.self, forKey: .type)
        name = try container.decode(String.self, forKey: .name)
    }
}
