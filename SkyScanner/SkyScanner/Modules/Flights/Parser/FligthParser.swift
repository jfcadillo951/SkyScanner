//
//  FligthParser.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class FligthParser: NSObject {
    static func parseDuration(min: Int) -> String {
        let h = min/60
        let resMin = min - h*60
        var s = ""
        if h > 0 {
            s = String(h) + "h"
            if resMin > 0 {
                s = s + " "
            }
        }
        if resMin > 0 {
            s = s + String(resMin) + "min"
        }
        return s
    }

}
