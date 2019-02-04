//
//  SortOption.swift
//  SkyScanner
//
//  Created by Nisum on 2/4/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

enum SortType: String {
    case price
    case duration
}

enum SortOrder: String {
    case asc
    case desc
}

class SortOptionViewModel: NSObject {
    let sortType: SortType
    let sortOrder: SortOrder
    let name: String
    var isSelected: Bool = false

    init(sortType: SortType,
         sortOrder: SortOrder,
         name: String,
         isSelected: Bool = false) {
        self.sortType = sortType
        self.sortOrder = sortOrder
        self.name = name
        self.isSelected = isSelected
    }
}
