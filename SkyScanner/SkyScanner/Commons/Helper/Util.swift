//
//  Util.swift
//  SkyScanner
//
//  Created by Nisum on 2/3/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class Util: NSObject {
    static func compare(a: [String: String], b: [String: String]) -> Bool {
        for itema in a {
            if let itemb = b[itema.key] {
                if itemb != itema.value {
                    return false
                }
            } else {
                return true
            }
        }
        return true
    }

    
}
