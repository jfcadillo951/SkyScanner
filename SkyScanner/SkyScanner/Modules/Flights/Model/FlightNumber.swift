//
//  FlightNumber.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class FlightNumber: Mappable {
    var flightNumber: String?
    var carrierId: Int?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        flightNumber                  <-      map["FlightNumber"]
        carrierId                     <-      map["CarrierId"]
    }
}
