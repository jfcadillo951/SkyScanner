//
//  Query.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class Query: Mappable {
    var country: String?
    var currency: String?
    var locale: String?
    var adults: Int?
    var children: Int?
    var infants: Int?
    var originPlace: String?
    var destinationPlace: String?
    var outboundDate: String?
    var inboundDate: String?
    var locationSchema: String?
    var cabinClass: String?
    var groupPricing: Bool?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        country                     <-      map["Country"]
        currency                    <-      map["Currency"]
        locale                      <-      map["Locale"]
        adults                      <-      map["Adults"]
        children                    <-      map["Children"]
        infants                     <-      map["Infants"]
        originPlace                 <-      map["OriginPlace"]
        destinationPlace            <-      map["DestinationPlace"]
        outboundDate                <-      map["OutboundDate"]
        inboundDate                 <-      map["InboundDate"]
        locationSchema              <-      map["LocationSchema"]
        cabinClass                  <-      map["CabinClass"]
        groupPricing                <-      map["GroupPricing"]

    }
}
