//
//  Currency.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

struct Currency: Codable {
    let code: String
    let symbol: String
    let thousandsSeparator: String
    let decimalSeparator: String
    let symbolOnLeft: Bool
    let spaceBetweenAmountAndSymbol: Bool
    let roundingCoefficient: Int
    let decimalDigits: Int

    private enum CodingKeys: String, CodingKey {
        case code = "Code"
        case symbol = "Symbol"
        case thousandsSeparator = "ThousandsSeparator"
        case decimalSeparator = "DecimalSeparator"
        case symbolOnLeft = "SymbolOnLeft"
        case spaceBetweenAmountAndSymbol = "SpaceBetweenAmountAndSymbol"
        case roundingCoefficient = "RoundingCoefficient"
        case decimalDigits = "DecimalDigits"

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        symbol = try container.decode(String.self, forKey: .symbol)
        thousandsSeparator = try container.decode(String.self, forKey: .thousandsSeparator)
        decimalSeparator = try container.decode(String.self, forKey: .decimalSeparator)
        symbolOnLeft = try container.decode(Bool.self, forKey: .symbolOnLeft)
        spaceBetweenAmountAndSymbol = try container.decode(Bool.self, forKey: .spaceBetweenAmountAndSymbol)
        roundingCoefficient = try container.decode(Int.self, forKey: .roundingCoefficient)
        decimalDigits = try container.decode(Int.self, forKey: .decimalDigits)
    }
}
