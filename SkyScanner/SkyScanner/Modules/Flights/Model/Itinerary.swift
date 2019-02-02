//
//  Itinerary.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class Itinerary: Mappable {
    var outboundLegId: String?
    var inboundLegId: String?
    var pricingOptions: [PricingOption]?
    var bookingDetailsLink: BookingDetailsLink?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        outboundLegId               <-      map["OutboundLegId"]
        inboundLegId                <-      map["InboundLegId"]
        pricingOptions              <-      map["PricingOptions"]
        bookingDetailsLink          <-      map["BookingDetailsLink"]
    }
}
