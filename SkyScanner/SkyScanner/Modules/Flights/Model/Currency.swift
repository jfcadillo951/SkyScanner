//
//  Currency.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class Currency: Mappable {
    var code: String?
    var symbol: String?
    var thousandsSeparator: String?
    var decimalSeparator: String?
    var symbolOnLeft: Bool?
    var spaceBetweenAmountAndSymbol: Bool?
    var roundingCoefficient: Int?
    var decimalDigits: Int?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        code                         <-      map["Code"]
        symbol                       <-      map["Symbol"]
        thousandsSeparator           <-      map["ThousandsSeparator"]
        decimalSeparator             <-      map["DecimalSeparator"]
        symbolOnLeft                 <-      map["SymbolOnLeft"]
    }
}
