//
//  ServiceApiSpy.swift
//  SkyScannerTests
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import XCTest
@testable import SkyScanner

class ServiceApiSuccesSpy: ServiceApiProtocol {

    var createSessionWasCalled = false
    var createSessionExpectation: XCTestExpectation?
    func createSession(cabinclass: String, country: String, currency: String, locale: String, locationSchema: String, originplace: String, destinationplace: String, outbounddate: String, inbounddate: String, adults: String, children: String, infants: String, apikey: String, onSuccess: @escaping ((String) -> Void), onFailure: @escaping ((NSError?, Int) -> Void)) {
        createSessionWasCalled = true
        createSessionExpectation?.fulfill()
        onSuccess("http://www.google.com")
    }

    var pollSessionWasCalled = false
    var pollSessionExpectation: XCTestExpectation?
    func pollSession(sessionUrl: String, apiKey: String, onSuccess: @escaping ((Data) -> Void), onFailure: @escaping ((NSError?, Int) -> Void)) {
        pollSessionWasCalled = true
        if let path = Bundle.main.path(forResource: "GET_POLLSESION_200", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                pollSessionExpectation?.fulfill()
                onSuccess(data)
            } catch {
                onFailure(nil, -1)
            }
        } else {
            onFailure(nil, -1)
        }
    }
}
