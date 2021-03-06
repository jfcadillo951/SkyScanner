//
//  FlightsLivePrices.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

protocol FlightsLivePricesPresenterProtocol {
    func getItineraries(cabinclass: String,
                        country: String,
                        currency: String,
                        locale: String,
                        locationSchema: String,
                        originplace: String,
                        destinationplace: String,
                        outbounddate: String,
                        inbounddate: String,
                        adults: String,
                        children: String,
                        infants: String)
    func displaySortOptions(in point: CGPoint)
    var selectedSortOptionIndex: Int { get set }
}
class FlightLivePricesPresenter: FlightsLivePricesPresenterProtocol {
    let repo: FlightRepositoryProtocol
    let view: FlightLivePricesViewProtocol
    let itinerariesPageSize = 1000
    var itineraries: [ItineraryViewModel] = []
    var skeletonItineraries: [ItineraryViewModel] = []
    var sortOptions: [SortOptionViewModel] = []
    var selectedSortOptionIndex: Int = 0

    init(repo: FlightRepositoryProtocol = FlightRepository(), view: FlightLivePricesViewProtocol) {
        self.repo = repo
        self.view = view
        getSkeletonItinerariesViewModel()
        getSortOptions()
    }

    private func _getItineraries(cabinclass: String,
                                 country: String,
                                 currency: String,
                                 locale: String,
                                 locationSchema: String,
                                 originplace: String,
                                 destinationplace: String,
                                 outbounddate: String,
                                 inbounddate: String,
                                 adults: String,
                                 children: String,
                                 infants: String,
                                 pageIndex: Int,
                                 pageSize: Int,
                                 sortType: String,
                                 sortOrder: String) {
        repo.getItineraries(cabinclass: cabinclass,
                            country: country,
                            currency: currency,
                            locale: locale,
                            locationSchema: locationSchema,
                            originplace: originplace,
                            destinationplace: destinationplace,
                            outbounddate: outbounddate,
                            inbounddate: inbounddate,
                            adults: adults,
                            children: children,
                            infants: infants,
                            pageIndex: pageIndex,
                            pageSize: itinerariesPageSize,
                            sortType: sortType,
                            sortOrder: sortOrder,
                            onSuccess: { [weak self] (pollSession) in
                                guard let `self` = self else { return }
                                self.view.dismissLoading()
                                if pollSession.itineraries?.count ?? 0 > 0 {
                                    let itinerariesPageResult = self.parseLivePrices(pollSession: pollSession)
                                    var indexPaths: [IndexPath] = []
                                    for (index,_) in itinerariesPageResult.enumerated() {
                                        indexPaths.append(IndexPath(row: self.itineraries.count+index, section: 0))
                                    }
                                    self.itineraries.append(contentsOf: itinerariesPageResult)
                                    self.view.showItineraries(viewModel: self.itineraries, indexPaths: indexPaths)
                                    self._getItineraries(cabinclass: cabinclass,
                                                         country: country,
                                                         currency: currency,
                                                         locale: locale,
                                                         locationSchema: locationSchema,
                                                         originplace: originplace,
                                                         destinationplace: destinationplace,
                                                         outbounddate: outbounddate,
                                                         inbounddate: inbounddate,
                                                         adults: adults,
                                                         children: children,
                                                         infants: infants,
                                                         pageIndex: pageIndex+1,
                                                         pageSize: pageSize,
                                                         sortType: sortType,
                                                         sortOrder: sortOrder)
                                } else {
                                    self.view.stopDisplayResults()
                                }

        }) { (error, statusCode) in
            // TODO: Show Error message
            self.view.dismissLoading()
            self.view.showError(title: StringConstant.APP_NAME, message: StringConstant.genericErrorMessage)
        }
    }

    func getItineraries(cabinclass: String, country: String, currency: String, locale: String, locationSchema: String, originplace: String, destinationplace: String, outbounddate: String, inbounddate: String, adults: String, children: String, infants: String) {
        self.view.showLoading(viewModel: skeletonItineraries)
        itineraries = []
        let pageIndex = 0
        self._getItineraries(cabinclass: cabinclass,
                             country: country,
                             currency: currency,
                             locale: locale,
                             locationSchema: locationSchema,
                             originplace: originplace,
                             destinationplace: destinationplace,
                             outbounddate: outbounddate,
                             inbounddate: inbounddate,
                             adults: adults,
                             children: children,
                             infants: infants,
                             pageIndex: pageIndex,
                             pageSize: itinerariesPageSize,
                             sortType: sortOptions[selectedSortOptionIndex].sortType.rawValue,
                             sortOrder: sortOptions[selectedSortOptionIndex].sortOrder.rawValue)
    }

    func displaySortOptions(in point: CGPoint) {
        self.view.showSortOptions(viewModel: sortOptions, selectedIndex: selectedSortOptionIndex, in: point)
    }

    private func parseLivePrices(pollSession: PollSession) -> [ItineraryViewModel] {
        let legsDict = repo.legsDict
        let segmentsDict = repo.segmentsDict
        let placesDict = repo.placesDict
        let carriesDict = repo.carriersDict
        let agentsDict = repo.agentsDict
        let currencyDict = repo.currencyDict

        var array: [ItineraryViewModel] = []
        for item in pollSession.itineraries ?? [] {
            let viewModel = ItineraryViewModel()
            viewModel.outboundLeg = parseLeg(legId: item.outboundLegId ?? "", legsDict: legsDict, carriesDict: carriesDict, placesDict: placesDict)
            viewModel.inboundLeg = parseLeg(legId: item.inboundLegId ?? "", legsDict: legsDict, carriesDict: carriesDict, placesDict: placesDict)
            let priceOption = item.pricingOptions?.sorted(by: { (a, b) -> Bool in
                return a.price ?? 0 < b.price ?? 0
            }).first
            viewModel.aditionalString = String(priceOption?.quoteAgeInMinutes ?? 0)
            viewModel.priceDescription = "Cheapest" + " Shortest"
            viewModel.finalPrice = priceOption?.price?.displayAsString(with: (currencyDict.first)!.value)
            array.append(viewModel)
        }
        return array
    }

    private func parseLeg(legId: String,
                          legsDict: [String: Leg],
                          carriesDict: [Int: Carrier],
                          placesDict: [Int: Place]) -> LegViewModel? {

        if let leg = legsDict[legId],
            let carrier = carriesDict[leg.carriers?.first ?? 0],
            let originPlace = placesDict[leg.originStation ?? 0],
            let destinationPlace = placesDict[leg.destinationStation ?? 0] {
            let legViewModel = LegViewModel()
            legViewModel.legUrl = carrier.imageUrl
            legViewModel.segmentsCount = leg.segmentIds?.count
            legViewModel.duration = FligthParser.parseDuration(minutes: leg.duration ?? 0)
            legViewModel.originPlace = originPlace.code
            legViewModel.destinationPlace = destinationPlace.code
            legViewModel.timeDescription = DateHelper.sharedInstance.parse(string: leg.departure ?? "", from: .timestampWithoutZone, to: .hoursMinute) + " - " +
                                            DateHelper.sharedInstance.parse(string: leg.arrival ?? "", from: .timestampWithoutZone, to: .hoursMinute)
            return legViewModel
        } else {
            return nil
        }
    }

    private func getSortOptions() {
        sortOptions = []
        sortOptions.append(SortOptionViewModel(sortType: .price, sortOrder: .asc, name: "Price"))
        sortOptions.append(SortOptionViewModel(sortType: .duration, sortOrder: .asc, name: "Duration"))
        selectedSortOptionIndex = 0
        sortOptions[selectedSortOptionIndex].isSelected = true
    }

    private func getSkeletonItinerariesViewModel() {
        skeletonItineraries = []
        var i = 0
        while i < 10 {
            let itinerayViewModel = ItineraryViewModel()
            itinerayViewModel.isSkeleton = true
            itinerayViewModel.inboundLeg = LegViewModel()
            itinerayViewModel.inboundLeg?.isSkeleton = true
            itinerayViewModel.outboundLeg = LegViewModel()
            itinerayViewModel.outboundLeg?.isSkeleton = true
            skeletonItineraries.append(itinerayViewModel)
            i = i + 1
        }
    }
}
