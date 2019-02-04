//
//  Double+Extension.swift
//  SkyScanner
//
//  Created by Nisum on 2/4/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

extension Double {
    func displayAsString(with currency: Currency) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.currencyDecimalSeparator = currency.decimalSeparator ?? ""
        formatter.maximumFractionDigits = currency.decimalDigits ?? 0
        formatter.currencyGroupingSeparator = currency.thousandsSeparator

        let formattedAbsoluteValue = formatter.string(from: abs(self) as NSNumber)!
        return (currency.symbol ?? "") + " " + formattedAbsoluteValue
    }
}
