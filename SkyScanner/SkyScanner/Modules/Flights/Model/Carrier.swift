//
//  Carrier.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class Carrier: Mappable {
    var id: Int?
    var code: String?
    var name: String?
    var imageUrl: String?
    var displayCode: String?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id                  <-      map["Id"]
        code                <-      map["Code"]
        name                <-      map["Name"]
        imageUrl            <-      map["ImageUrl"]
        displayCode         <-      map["DisplayCode"]
    }
}
