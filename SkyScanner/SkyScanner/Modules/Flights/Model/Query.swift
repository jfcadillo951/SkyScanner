//
//  Query.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

struct Query: Codable {
    let country: String
    let currency: String
    let locale: String
    let adults: Int
    let children: Int
    let infants: Int
    let originPlace: String
    let destinationPlace: String
    let outboundDate: String
    let inboundDate: String
    let locationSchema: String
    let cabinClass: String
    let groupPricing: Bool

    private enum CodingKeys: String, CodingKey {
        case country = "Country"
        case currency = "Currency"
        case locale = "Locale"
        case adults = "Adults"
        case children = "Children"
        case infants = "Infants"
        case originPlace = "OriginPlace"
        case destinationPlace = "DestinationPlace"
        case outboundDate = "OutboundDate"
        case inboundDate = "InboundDate"
        case locationSchema = "LocationSchema"
        case cabinClass = "CabinClass"
        case groupPricing = "GroupPricing"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        country = try container.decode(String.self, forKey: .country)
        currency = try container.decode(String.self, forKey: .currency)
        locale = try container.decode(String.self, forKey: .locale)
        adults = try container.decode(Int.self, forKey: .adults)
        children = try container.decode(Int.self, forKey: .children)
        infants = try container.decode(Int.self, forKey: .infants)
        originPlace = try container.decode(String.self, forKey: .originPlace)
        destinationPlace = try container.decode(String.self, forKey: .destinationPlace)
        outboundDate = try container.decode(String.self, forKey: .outboundDate)
        inboundDate = try container.decode(String.self, forKey: .inboundDate)
        locationSchema = try container.decode(String.self, forKey: .locationSchema)
        cabinClass = try container.decode(String.self, forKey: .cabinClass)
        groupPricing = try container.decode(Bool.self, forKey: .groupPricing)
    }
}
