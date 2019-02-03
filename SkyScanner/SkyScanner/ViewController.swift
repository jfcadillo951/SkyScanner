//
//  ViewController.swift
//  SkyScanner
//
//  Created by Nisum on 1/29/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let repo = FlightRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let api = ServiceApi.init()
//        //"http://partners.api.skyscanner.net/apiservices/pricing/uk1/v1.0/c216b224-5223-48c4-af3c-40fbd7d405a2", apiKey: "ss630745725358065467897349852985")
//        api.pollSession(sessionUrl: "http://partners.api.skyscanner.net/apiservices/pricing/uk1/v1.0/c216b224-5223-48c4-af3c-40fbd7d405a2",
//                        apiKey: "ss630745725358065467897349852985", onSuccess: { (data) in
//                if let string = String(data: data, encoding: String.Encoding.utf8),
//                    let pollSessionResponse = PollSession(JSONString: string) {
//                    print("OKKKKK")
//                }
//                else {
//                    print("fdfsdf")
//                }
//
//        }) { (error, statusCode) in
//
//        }

        repo.getItineraries(cabinclass: "Economy",
                            country: "UK",
                            currency: "GBP",
                            locale: "en-GB",
                            locationSchema: "iata",
                            originplace: "EDI",
                            destinationplace: "LHR",
                            outbounddate: "2019-02-25",
                            inbounddate: "2019-02-26",
                            adults: "1",
                            children: "0",
                            infants: "0", onSuccess: { (pollSession) in

        }) { (error, statusCode) in

        }


        //        api.createSession(apikey: "ss630745725358065467897349852985", onSuccess: { (data) in
//
//        }) { (error, status) in
//
//        }
    }


}

