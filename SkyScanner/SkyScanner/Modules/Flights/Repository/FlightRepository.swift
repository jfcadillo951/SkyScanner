//
//  FlightRepository.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

protocol FlightRepositoryProtocol {
    var legsDict: [String: Leg] { get set }
    var segmentsDict: [Int: Segment] { get set }
    var placesDict: [Int: Place] { get set }
    var carriersDict: [Int: Carrier] { get set }
    var agentsDict: [Int: Agent] { get set }

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
                        infants: String,
                        pageIndex: Int,
                        pageSize: Int,
                        onSuccess: @escaping ((PollSession) -> Void),
                        onFailure: @escaping ((NSError?, Int) -> Void))
}

class FlightRepository: FlightRepositoryProtocol {
    let api: ServiceApiProtocol
    let storage: StorageInMemoryProtocol
    let appKeys: SkyScannerKeys = SkyScannerKeysImpl()
    var sessionParameters: [String: String] = [:]
    var legsDict: [String: Leg] = [:]
    var segmentsDict: [Int: Segment] = [:]
    var placesDict: [Int: Place] = [:]
    var carriersDict: [Int: Carrier] = [:]
    var agentsDict: [Int: Agent] = [:]

    init(api: ServiceApiProtocol = ServiceApi(), storage: StorageInMemoryProtocol = StorageInMemory.shared) {
        self.api = api
        self.storage = storage
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
                        shouldRetryOnlyOnce: Bool,
                        pageIndex: Int,
                        pageSize: Int,
                        onSuccess: @escaping ((PollSession) -> Void),
                        onFailure: @escaping ((NSError?, Int) -> Void)) {

        var tempSessionDict: [String: String] = [:]
        tempSessionDict["cabinclass"] = cabinclass
        tempSessionDict["country"] = country
        tempSessionDict["currency"] = currency
        tempSessionDict["locale"] = locale
        tempSessionDict["locationSchema"] = locationSchema
        tempSessionDict["originplace"] = originplace
        tempSessionDict["destinationplace"] = destinationplace
        tempSessionDict["outbounddate"] = outbounddate
        tempSessionDict["inbounddate"] = inbounddate
        tempSessionDict["adults"] = adults
        tempSessionDict["children"] = children
        tempSessionDict["infants"] = infants

        if !Util.compare(a: sessionParameters, b: tempSessionDict) {
            self.storage.remove(for: .pollingUrl)
        }

        if let url = self.storage.get(key: .pollingUrl) as? String {
            self.api.pollSession(sessionUrl: url, apiKey: appKeys.getApiKey(), pageIndex: pageIndex, pageSize: pageSize, onSuccess: { (data) in
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
                                         infants: infants, shouldRetryOnlyOnce: false,
                                         pageIndex: pageIndex,
                                         pageSize: pageSize,
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
                                    self.sessionParameters = [:]
                                    self.sessionParameters["cabinclass"] = cabinclass
                                    self.sessionParameters["country"] = country
                                    self.sessionParameters["currency"] = currency
                                    self.sessionParameters["locale"] = locale
                                    self.sessionParameters["locationSchema"] = locationSchema
                                    self.sessionParameters["originplace"] = originplace
                                    self.sessionParameters["destinationplace"] = destinationplace
                                    self.sessionParameters["outbounddate"] = outbounddate
                                    self.sessionParameters["inbounddate"] = inbounddate
                                    self.sessionParameters["adults"] = adults
                                    self.sessionParameters["children"] = children
                                    self.sessionParameters["infants"] = infants
                                    self.storage.set(object: pollSessionurl, for: .pollingUrl)
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
                                                         shouldRetryOnlyOnce: false,
                                                         pageIndex: pageIndex,
                                                         pageSize: pageSize,
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
                        infants: String,
                        pageIndex: Int,
                        pageSize: Int,
                        onSuccess: @escaping ((PollSession) -> Void),
                        onFailure: @escaping ((NSError?, Int) -> Void)) {
        if pageIndex == 0 {
            self.cleanDicts()
        }
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
                             shouldRetryOnlyOnce: true,
                             pageIndex: pageIndex,
                             pageSize: pageSize,
                             onSuccess: { [weak self] (pollSession) in
                                guard let `self` = self else { return }
                                self.addPollSessionToDicts(pollSession: pollSession)
                                onSuccess(pollSession)
        }, onFailure: { (error, statusCode) in
            onFailure(error, statusCode)
        })
    }

    private func cleanDicts() {
        legsDict = [:]
        segmentsDict = [:]
        placesDict = [:]
        carriersDict = [:]
        agentsDict = [:]
    }

    private func addPollSessionToDicts(pollSession: PollSession) {
        addLegsToDict(pollSession: pollSession)
        addSegmentsToDict(pollSession: pollSession)
        addPlacesToDict(pollSession: pollSession)
        addCarriesToDict(pollSession: pollSession)
        addAgentsToDict(pollSession: pollSession)
    }

    private func addLegsToDict(pollSession: PollSession)  {
        var dict: [String: Leg] = [:]
        for item in pollSession.legs ?? [] {
            dict[item.id ?? ""] = item
        }
        for item in dict {
            legsDict[item.key] = item.value
        }
    }

    private func addSegmentsToDict(pollSession: PollSession) {
        var dict: [Int: Segment] = [:]
        for item in pollSession.segments ?? [] {
            dict[item.id ?? 0] = item
        }
        for item in dict {
            segmentsDict[item.key] = item.value
        }
    }

    private func addPlacesToDict(pollSession: PollSession) {
        var dict: [Int: Place] = [:]
        for item in pollSession.places ?? [] {
            dict[item.id ?? 0] = item
        }
        for item in dict {
            placesDict[item.key] = item.value
        }
    }

    private func addCarriesToDict(pollSession: PollSession) {
        var dict: [Int: Carrier] = [:]
        for item in pollSession.carriers ?? [] {
            dict[item.id ?? 0] = item
        }
        for item in dict {
            carriersDict[item.key] = item.value
        }
    }

    private func addAgentsToDict(pollSession: PollSession) {
        var dict: [Int: Agent] = [:]
        for item in pollSession.agents ?? [] {
            dict[item.id ?? 0] = item
        }
        for item in dict {
            agentsDict[item.key] = item.value
        }
    }
}
