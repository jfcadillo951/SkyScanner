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
}
class FlightLivePricesPresenter: FlightsLivePricesPresenterProtocol {
    let repo: FlightRepositoryProtocol
    let view: FlightLivePricesViewProtocol
    let itinerariesPageSize = 40
    var itineraries: [ItineraryViewModel] = []

    init(repo: FlightRepositoryProtocol = FlightRepository(), view: FlightLivePricesViewProtocol) {
        self.repo = repo
        self.view = view
    }

    private func _getItineraries(cabinclass: String, country: String, currency: String, locale: String, locationSchema: String, originplace: String, destinationplace: String, outbounddate: String, inbounddate: String, adults: String, children: String, infants: String, pageIndex: Int, pageSize: Int) {
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
                            onSuccess: { [weak self] (pollSession) in
                                guard let `self` = self else { return }
                                self.view.dismissLoading()
                                if pollSession.itineraries?.count ?? 0 > 0 {
                                    let itinerariesPageResult = FligthParser.parseLivePrices(pollSession: pollSession)
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
                                                         pageSize: pageSize)
                                } else {
                                    self.view.stopDisplayResults()
                                }

        }) { (error, statusCode) in
            // TODO: Show Error message
            self.view.dismissLoading()
        }
    }

    func getItineraries(cabinclass: String, country: String, currency: String, locale: String, locationSchema: String, originplace: String, destinationplace: String, outbounddate: String, inbounddate: String, adults: String, children: String, infants: String) {
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
                             pageSize: itinerariesPageSize)
    }
}
