//
//  FligthParser.swift
//  SkyScanner
//
//  Created by Nisum on 2/2/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class FligthParser: NSObject {
    static func parseDuration(minutes: Int) -> String {
        let hours = minutes/60
        let resMinutes = minutes - hours*60
        var result = ""
        if hours > 0 {
            result = String(hours) + "h"
            if resMinutes > 0 {
                result = result + " "
            }
        }
        if resMinutes > 0 {
            result = result + String(resMinutes) + "min"
        }
        return result
    }

}
