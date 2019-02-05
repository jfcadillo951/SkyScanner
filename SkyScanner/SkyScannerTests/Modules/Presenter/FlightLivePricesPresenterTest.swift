//
//  FlightLivePricesPresenterTest.swift
//  SkyScannerTests
//
//  Created by Nisum on 2/4/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import XCTest
@testable import SkyScanner

class FlightLivePricesPresenterTest: XCTestCase {

    var presenter: FlightLivePricesPresenter!
    var repositorySpy: FlightRepositorySpy!
    var viewSpy: FlightLivePricesViewSpy!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        repositorySpy = FlightRepositorySpy()
        viewSpy = FlightLivePricesViewSpy()
        presenter = FlightLivePricesPresenter(repo: repositorySpy, view: viewSpy)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadingPricesOptions() {
        // Given

        // When -> on init
        presenter = FlightLivePricesPresenter(repo: repositorySpy, view: viewSpy)

        // Then
        XCTAssertEqual(presenter.sortOptions.count, 2)
        XCTAssertEqual(presenter.selectedSortOptionIndex, 0)
    }

    func testGetItinerariesSuccess() {
        // Givens

        // When
        presenter.getItineraries(cabinclass: "test",
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
                                 infants: "test")
        // Then

        XCTAssert(viewSpy.showLoadingWasCalled, "showLoadingWasCalled")
        XCTAssertEqual(viewSpy.showLoadingViewModel?.count, 10)
        XCTAssert(viewSpy.dismissLoadingWasCalled, "dismissLoadingWasCalled")
        XCTAssert(viewSpy.stopDisplayResultsWasCalled, "stopDisplayResultsWasCalled")
        XCTAssert(viewSpy.showItinerariesWasCalled, "showItinerariesWasCalled")
        XCTAssertEqual(viewSpy.showItinerariesViewModel?.count, 1)
    }

    func testGetItinerariesError() {
        // Givens
        let repoErrorSpy = FlightRepositoryErrorSpy()
        presenter = FlightLivePricesPresenter(repo: repoErrorSpy, view: viewSpy)

        // When
        presenter.getItineraries(cabinclass: "test",
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
                                 infants: "test")
        // Then

        XCTAssert(viewSpy.showLoadingWasCalled, "showLoadingWasCalled")
        XCTAssertEqual(viewSpy.showLoadingViewModel?.count, 10)
        XCTAssert(viewSpy.dismissLoadingWasCalled, "dismissLoadingWasCalled")
        XCTAssert(viewSpy.showErrorWasCalled, "showErrorWasCalled")
        XCTAssertEqual(viewSpy.showErrorTitle, "SkyScanner")
        XCTAssertEqual(viewSpy.showErrorMessage, "Something were wrong, please try it again later")
    }

    func testDisplaySortOptions() {
        // Given

        // When
        presenter.displaySortOptions(in: CGPoint.zero)

        // Then
        XCTAssert(viewSpy.showSortOptionsWasCalled, "showSortOptionsWasCalled")
        XCTAssertEqual(viewSpy.showSortOptionsViewModel?.count, 2)

    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
