//
//  BookingDetailsLink.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class BookingDetailsLink: Mappable {
    var uri: String?
    var body: String?
    var method: String?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        uri             <-      map["Uri"]
        body            <-      map["Body"]
        method          <-      map["Method"]
    }
}
