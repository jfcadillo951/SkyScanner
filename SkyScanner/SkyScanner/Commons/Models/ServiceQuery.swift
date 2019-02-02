//
//  ServiceQuery.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class ServiceQuery: Mappable {
    var dateTime: String?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        dateTime          <-      map["DateTime"]
    }
}
