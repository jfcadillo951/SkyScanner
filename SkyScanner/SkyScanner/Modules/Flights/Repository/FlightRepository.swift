//
//  FlightRepository.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

protocol FlightRepositoryProtocol {
    func getItiniraries(cabinclass: String,
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
                        onSuccess: @escaping ((PollSession) -> Void),
                        onFailure: @escaping ((NSError?, Int) -> Void))
}

class FlightRepository: FlightRepositoryProtocol {
    let api: ServiceApiProtocol
    let storage: StorageInMemoryProtocol
    let appKeys: SkyScannerKeys = SkyScannerKeysImpl()
    
    init(api: ServiceApiProtocol = ServiceApi(), storage: StorageInMemoryProtocol = StorageInMemory.shared) {
        self.api = api
        self.storage = storage
    }

    private func _getItiniraries(cabinclass: String,
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
                        shouldRetryOnlyOnce: Bool,
                        onSuccess: @escaping ((PollSession) -> Void),
                        onFailure: @escaping ((NSError?, Int) -> Void)) {

        if let url = self.storage.get(key: .pollingUrl) as? String {
            self.api.pollSession(sessionUrl: url, apiKey: appKeys.getApiKey(), onSuccess: { (data) in
                if let string = String(data: data, encoding: String.Encoding.utf8),
                    let pollSessionResponse = PollSession(JSONString: string) {
                    onSuccess(pollSessionResponse)
                }
                else {
                    onFailure(nil, -1)
                }
            }) { [weak self] (error, statusCode) in
                guard let `self` = self else { return }
                if statusCode == 410 && shouldRetryOnlyOnce {
                    self._getItiniraries(cabinclass: cabinclass,
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
                                         infants: infants, shouldRetryOnlyOnce: false,
                                         onSuccess: { (pollSession) in
                                            onSuccess(pollSession)
                    }, onFailure: { (error, statusCode) in
                        onFailure(error, statusCode)
                    })
                } else {
                    onFailure(error, statusCode)
                }
            }
        } else {
            self.api.createSession(cabinclass: cabinclass,
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
                                   apikey: appKeys.getApiKey(),
                                   onSuccess: { [weak self] (pollSessionurl) in
                                    guard let `self` = self else { return }
                                    self.storage.set(object: pollSessionurl, for: .pollingUrl)
                                    self._getItiniraries(cabinclass: cabinclass,
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
                                                         infants: infants, shouldRetryOnlyOnce: false,
                                                         onSuccess: { (pollSession) in
                                                            onSuccess(pollSession)
                                    }, onFailure: { (error, statusCode) in
                                        onFailure(error, statusCode)
                                    })
            }) { (error, statusCode) in
                onFailure(error, statusCode)
            }
        }
    }

    func getItiniraries(cabinclass: String,
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
                        onSuccess: @escaping ((PollSession) -> Void),
                        onFailure: @escaping ((NSError?, Int) -> Void)) {
        self._getItiniraries(cabinclass: cabinclass,
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
                             infants: infants, shouldRetryOnlyOnce: false,
                             onSuccess: { (pollSession) in
                                onSuccess(pollSession)
        }, onFailure: { (error, statusCode) in
            onFailure(error, statusCode)
        })
    }
}
