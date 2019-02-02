//
//  Place.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class Place: Mappable {
    var id: Int?
    var parentId: Int?
    var code: String?
    var type: String?
    var name: String?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id              <-      map["Id"]
        parentId        <-      map["ParentId"]
        code            <-      map["Code"]
        type            <-      map["Type"]
        name            <-      map["Name"]
    }
}
