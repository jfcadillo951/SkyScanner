//
//  ViewController.swift
//  SkyScanner
//
//  Created by Nisum on 1/29/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let api = ServiceApi.init()
        api.createSession(apikey: "ss630745725358065467897349852985", onSuccess: { (data) in

        }) { (error, status) in

        }
    }


}

