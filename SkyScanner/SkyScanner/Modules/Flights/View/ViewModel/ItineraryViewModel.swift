//
//  ItineraryViewModel.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class ItineraryViewModel: NSObject {
    var outboundLeg: LegViewModel?
    var inboundLeg: LegViewModel?
    var iconUrl: String?
    var aditionalString: String?
    var priceDescription: String?
    var finalPrice: String?
    var bookingDescription: String?
    var isSkeleton: Bool = false
}
