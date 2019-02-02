//
//  Leg.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class Leg: Mappable {
    var id: String?
    var segmentIds: [Int]?
    var originStation: Int?
    var destinationStation: Int?
    var departure: String?
    var arrival: String?
    var duration: Int?
    var journeyMode: String?
    var stops: [Int]?
    var carriers: [Int]?
    var operatingCarriers: [Int]?
    var directionality: String?
    var flightNumbers: [FlightNumber]?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id                      <-      map["Id"]
        segmentIds              <-      map["SegmentIds"]
        originStation           <-      map["OriginStation"]
        destinationStation      <-      map["DestinationStation"]
        departure               <-      map["Departure"]
        arrival                 <-      map["Arrival"]
        duration                <-      map["Duration"]
        journeyMode             <-      map["JourneyMode"]
        stops                   <-      map["Stops"]
        carriers                <-      map["Carriers"]
        operatingCarriers       <-      map["OperatingCarriers"]
        directionality          <-      map["Directionality"]
        flightNumbers           <-      map["FlightNumbers"]
    }
}
