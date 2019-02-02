//
//  PollSession.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class PollSession: Mappable {
    var sessionKey: String?
    var query: Query?
    var status: String?
    var legs: [Leg]?
    var segments: [Segment]?
    var carriers: [Carrier]?
    var agents: [Agent]?
    var places: [Place]?
    var currencies: [Currency]?
    var serviceQuery: ServiceQuery?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        sessionKey          <-      map["SessionKey"]
        query               <-      map["Query"]
        status              <-      map["Status"]
        legs                <-      map["Legs"]
        segments            <-      map["Segments"]
        carriers            <-      map["Carriers"]
        agents              <-      map["Agents"]
        places              <-      map["Places"]
        currencies          <-      map["Currencies"]
        serviceQuery        <-      map["ServiceQuery"]
    }
}
