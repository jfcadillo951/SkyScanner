//
//  FligthParser.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class FligthParser: NSObject {
    static func parseLivePrices(pollSession: PollSession) -> [ItineraryViewModel] {
        let legsDict = getLegsDict(pollSession: pollSession)
        let segmentsDict = getSegmentsDict(pollSession: pollSession)
        let placesDict = getPlacesDict(pollSession: pollSession)
        let carriesDict = getCarriesDict(pollSession: pollSession)
        let agentsDict = getAgentsDict(pollSession: pollSession)

        var array: [ItineraryViewModel] = []
        for item in pollSession.itineraries ?? [] {
            let viewModel = ItineraryViewModel()
            if let leg = legsDict[item.outboundLegId ?? ""],
                let carrier = carriesDict[leg.carriers?.first ?? 0],
                let originPlace = placesDict[leg.originStation ?? 0],
                let destinationPlace = placesDict[leg.destinationStation ?? 0] {
                let legViewModel = LegViewModel()
                legViewModel.legUrl = carrier.imageUrl
                legViewModel.segmentsCount = leg.segmentIds?.count
                legViewModel.duration = parseDuration(min: leg.duration ?? 0)
                legViewModel.originPlace = originPlace.code
                legViewModel.destinationPlace = destinationPlace.code
                legViewModel.timeDescription = leg.arrival

                viewModel.outboundLeg = legViewModel
            }
            if let leg = legsDict[item.inboundLegId ?? ""],
                let carrier = carriesDict[leg.carriers?.first ?? 0],
                let originPlace = placesDict[leg.originStation ?? 0],
                let destinationPlace = placesDict[leg.destinationStation ?? 0] {
                let legViewModel = LegViewModel()
                legViewModel.legUrl = carrier.imageUrl
                legViewModel.segmentsCount = leg.segmentIds?.count
                legViewModel.duration = parseDuration(min: leg.duration ?? 0)
                legViewModel.originPlace = originPlace.code
                legViewModel.destinationPlace = destinationPlace.code
                legViewModel.timeDescription = leg.arrival

                viewModel.inboundLeg = legViewModel
            }

            let priceOption = item.pricingOptions?.sorted(by: { (a, b) -> Bool in
                return a.price ?? 0 < b.price ?? 0
            }).first
            viewModel.aditionalString = String(priceOption?.quoteAgeInMinutes ?? 0)
            viewModel.priceDescription = "Cheapest" + "   Shortest"
            viewModel.finalPrice = String(priceOption?.price ?? 0.0)
            array.append(viewModel)
        }
        return array
    }

    static func getLegsDict(pollSession: PollSession) -> [String: Leg] {
        var dict: [String: Leg] = [:]
        for item in pollSession.legs ?? [] {
            dict[item.id ?? ""] = item
        }
        return dict
    }

    static func getSegmentsDict(pollSession: PollSession) -> [Int: Segment] {
        var dict: [Int: Segment] = [:]
        for item in pollSession.segments ?? [] {
            dict[item.id ?? 0] = item
        }
        return dict
    }

    static func getPlacesDict(pollSession: PollSession) -> [Int: Place] {
        var dict: [Int: Place] = [:]
        for item in pollSession.places ?? [] {
            dict[item.id ?? 0] = item
        }
        return dict
    }

    static func getCarriesDict(pollSession: PollSession) -> [Int: Carrier] {
        var dict: [Int: Carrier] = [:]
        for item in pollSession.carriers ?? [] {
            dict[item.id ?? 0] = item
        }
        return dict
    }

    static func getAgentsDict(pollSession: PollSession) -> [Int: Agent] {
        var dict: [Int: Agent] = [:]
        for item in pollSession.agents ?? [] {
            dict[item.id ?? 0] = item
        }
        return dict
    }

    static func parseDuration(min: Int) -> String {
        let h = min/60
        let resMin = min - h*60
        var s = ""
        if h > 0 {
            s = String(h) + "h"
            if resMin > 0 {
                s = s + " "
            }
        }
        if resMin > 0 {
            s = s + String(resMin) + "min"
        }
        return s
    }

}
