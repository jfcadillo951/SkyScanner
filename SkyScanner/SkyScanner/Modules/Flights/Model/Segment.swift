//
//  Segment.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

struct Segment: Codable {
    let id: Int
    let originStation: Int
    let destinationStation: Int
    let departureDateTime: String
    let arrivalDateTime: String
    let carrier: Int
    let operatingCarrier: Int
    let duration: Int
    let flightNumber: String
    let journeyMode: String
    let directionality: String

    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case originStation = "OriginStation"
        case destinationStation = "DestinationStation"
        case departureDateTime = "DepartureDateTime"
        case arrivalDateTime = "ArrivalDateTime"
        case carrier = "Carrier"
        case operatingCarrier = "OperatingCarrier"
        case duration = "Duration"
        case flightNumber = "FlightNumber"
        case journeyMode = "JourneyMode"
        case directionality = "Directionality"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        originStation = try container.decode(Int.self, forKey: .originStation)
        destinationStation = try container.decode(Int.self, forKey: .destinationStation)
        departureDateTime = try container.decode(String.self, forKey: .departureDateTime)
        arrivalDateTime = try container.decode(String.self, forKey: .arrivalDateTime)
        carrier = try container.decode(Int.self, forKey: .carrier)
        operatingCarrier = try container.decode(Int.self, forKey: .operatingCarrier)
        duration = try container.decode(Int.self, forKey: .duration)
        flightNumber = try container.decode(String.self, forKey: .flightNumber)
        journeyMode = try container.decode(String.self, forKey: .journeyMode)
        directionality = try container.decode(String.self, forKey: .directionality)
    }
}
