//
//  LegViewModel.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class LegViewModel: NSObject {
    var legUrl: String?
    var segmentsCount: Int?
    var duration: String?
    var originPlace: String?
    var destinationPlace: String?
    var timeDescription: String?
    var isSkeleton: Bool = false
}
