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

    init(repo: FlightRepositoryProtocol = FlightRepository(), view: FlightLivePricesViewProtocol) {
        self.repo = repo
        self.view = view
    }

    func getItineraries(cabinclass: String, country: String, currency: String, locale: String, locationSchema: String, originplace: String, destinationplace: String, outbounddate: String, inbounddate: String, adults: String, children: String, infants: String) {
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
                            onSuccess: { [weak self] (pollSession) in
                                guard let `self` = self else { return }
                                self.view.showItineraries(viewModel: FligthParser.parseLivePrices(pollSession: pollSession))
        }) { (error, statusCode) in
            // TODO: Show Error message
        }
    }
}
