//
//  Segment.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class Segment: Mappable {
    var id: Int?
    var originStation: Int?
    var destinationStation: Int?
    var departureDateTime: String?
    var arrivalDateTime: String?
    var carrier: Int?
    var operatingCarrier: Int?
    var duration: Int?
    var flightNumber: String?
    var journeyMode: String?
    var directionality: String?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id                          <-      map["Id"]
        originStation               <-      map["OriginStation"]
        destinationStation          <-      map["DestinationStation"]
        departureDateTime           <-      map["DepartureDateTime"]
        arrivalDateTime             <-      map["ArrivalDateTime"]
        carrier                     <-      map["Carrier"]
        operatingCarrier            <-      map["OperatingCarrier"]
        duration                    <-      map["Duration"]
        flightNumber                <-      map["FlightNumber"]
        journeyMode                 <-      map["JourneyMode"]
        directionality              <-      map["Directionality"]
    }
}
