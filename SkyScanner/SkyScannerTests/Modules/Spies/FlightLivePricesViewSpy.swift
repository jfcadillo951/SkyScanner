//
//  FlightLivePricesViewSpy.swift
//  SkyScannerTests
//
//  Created by Nisum on 2/5/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import XCTest
@testable import SkyScanner

class FlightLivePricesViewSpy: FlightLivePricesViewProtocol {

    var showItinerariesWasCalled = false
    var showItinerariesViewModel: [ItineraryViewModel]?
    func showItineraries(viewModel: [ItineraryViewModel], indexPaths: [IndexPath]) {
        showItinerariesWasCalled = true
        showItinerariesViewModel = viewModel
    }

    var showSortOptionsWasCalled = false
    var showSortOptionsViewModel: [SortOptionViewModel]?
    func showSortOptions(viewModel: [SortOptionViewModel], selectedIndex: Int, in point: CGPoint) {
        showSortOptionsWasCalled = true
        showSortOptionsViewModel = viewModel
    }

    var showLoadingWasCalled = false
    var showLoadingViewModel: [ItineraryViewModel]?
    func showLoading(viewModel: [ItineraryViewModel]) {
        showLoadingWasCalled = true
        showLoadingViewModel = viewModel
    }

    var dismissLoadingWasCalled = false
    func dismissLoading() {
        dismissLoadingWasCalled = true
    }

    var stopDisplayResultsWasCalled = false
    func stopDisplayResults() {
        stopDisplayResultsWasCalled = true
    }

    var showErrorWasCalled = false
    var showErrorTitle: String?
    var showErrorMessage: String?
    func showError(title: String, message: String) {
        showErrorWasCalled = true
        showErrorTitle = title
        showErrorMessage = message
    }

}
