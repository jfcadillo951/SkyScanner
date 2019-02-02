//
//  PricingOption.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class PricingOption: Mappable {
    var agents: [Agent]?
    var quoteAgeInMinutes: Int?
    var price: Double?
    var deeplinkUrl: String?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        agents                  <-      map["Agents"]
        quoteAgeInMinutes       <-      map["QuoteAgeInMinutes"]
        price                   <-      map["Price"]
        deeplinkUrl             <-      map["DeeplinkUrl"]
    }
}
