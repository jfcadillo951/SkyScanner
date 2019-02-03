//
//  FlightRepositoryTest.swift
//  SkyScannerTests
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import XCTest
@testable import SkyScanner

class FlightRepositoryTest: XCTestCase {

    var repo: FlightRepository!
    var apiSpy: ServiceApiSuccesSpy!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiSpy = ServiceApiSuccesSpy()
        repo = FlightRepository(api: apiSpy, storage: StorageInMemory.shared)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetItinitariesSuccess() {
        // given
        apiSpy.createSessionExpectation = expectation(description: "createSessionItinitariesSuccessExpectation")
        apiSpy.pollSessionExpectation = expectation(description: "pollSessionItinitariesSuccessExpectation")

        // when
        repo.getItineraries(cabinclass: "test",
                            country: "test",
                            currency: "test",
                            locale: "test",
                            locationSchema: "test",
                            originplace: "test",
                            destinationplace: "test",
                            outbounddate: "test",
                            inbounddate: "test",
                            adults: "test",
                            children: "test",
                            infants: "test",
                            onSuccess: { (pollSession) in
                                // then
                                XCTAssertTrue(self.apiSpy.createSessionWasCalled)
                                XCTAssertTrue(self.apiSpy.pollSessionWasCalled)
        }) { (error, statusCode) in

        }

        self.wait(for: [self.apiSpy.createSessionExpectation!,
                        self.apiSpy.pollSessionExpectation!], timeout: 10.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
