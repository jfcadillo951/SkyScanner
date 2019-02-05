//
//  FlightRepositorySpy.swift
//  SkyScannerTests
//
//  Created by Nisum on 2/4/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
@testable import SkyScanner

class FlightRepositorySpy: FlightRepositoryProtocol {
    var legsDict: [String : Leg] = [:]
    var segmentsDict: [Int : Segment] = [:]
    var placesDict: [Int : Place] = [:]
    var carriersDict: [Int : Carrier] = [:]
    var agentsDict: [Int : Agent] = [:]
    var currencyDict: [String : Currency] = [:]

    func getItineraries(cabinclass: String, country: String, currency: String, locale: String, locationSchema: String, originplace: String, destinationplace: String, outbounddate: String, inbounddate: String, adults: String, children: String, infants: String, pageIndex: Int, pageSize: Int, sortType: String, sortOrder: String, onSuccess: @escaping ((PollSession) -> Void), onFailure: @escaping ((NSError?, Int) -> Void)) {
        if pageIndex == 0 {
            let pollSession = PollSession()
            let itinerary = Itinerary()
            itinerary.outboundLegId = "1"
            itinerary.inboundLegId = "2"
            pollSession.itineraries = [itinerary]
            let legOutBound = Leg()
            legOutBound.id = "1"
            let legInBound = Leg()
            legInBound.id = "2"
            pollSession.legs = [legOutBound,legInBound]
            onSuccess(pollSession)
        } else {
            let pollSession = PollSession()
            pollSession.itineraries = []
            onSuccess(pollSession)
        }

    }
}

class FlightRepositoryErrorSpy: FlightRepositoryProtocol {
    var legsDict: [String : Leg] = [:]
    var segmentsDict: [Int : Segment] = [:]
    var placesDict: [Int : Place] = [:]
    var carriersDict: [Int : Carrier] = [:]
    var agentsDict: [Int : Agent] = [:]
    var currencyDict: [String : Currency] = [:]

    func getItineraries(cabinclass: String, country: String, currency: String, locale: String, locationSchema: String, originplace: String, destinationplace: String, outbounddate: String, inbounddate: String, adults: String, children: String, infants: String, pageIndex: Int, pageSize: Int, sortType: String, sortOrder: String, onSuccess: @escaping ((PollSession) -> Void), onFailure: @escaping ((NSError?, Int) -> Void)) {

        onFailure(nil, -1)
    }

}
