//
//  Agent.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

struct Agent: Codable {
    let id: Int
    let name: String
    let imageUrl: String
    let status: String
    let optimisedForMobile: Bool
    let type: String

    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case imageUrl = "ImageUrl"
        case status = "Status"
        case optimisedForMobile = "OptimisedForMobile"
        case type = "Type"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
        status = try container.decode(String.self, forKey: .status)
        optimisedForMobile = try container.decode(Bool.self, forKey: .optimisedForMobile)
        type = try container.decode(String.self, forKey: .type)
    }
}
