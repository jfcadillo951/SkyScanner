//
//  ServiceApi.swift
//  SkyScanner
//
//  Created by Nisum on 1/29/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

protocol ServiceApiProtocol {
    func createSession(cabinclass: String,
                       country: String,
                       currency: String,
                       locale: String,
                       locationSchema: String,
                       originplace: String,
                       destinationplace: String,
                       outbounddate: String,
                       inbounddate: String,
                       adults: String,
                       children: String,
                       infants: String,
                       apikey: String,
                       success: @escaping ((String) -> Void), error: @escaping ((NSError?, Int) -> Void))
}
class ServiceApi: ServiceApiProtocol {
    private let createSessionUrl = "http://partners.api.skyscanner.net/apiservices/pricing/v1.0/"

    func createSession(cabinclass: String = "Economy",
                       country: String = "UK",
                       currency: String = "GBP",
                       locale: String = "en-GB",
                       locationSchema: String = "iata",
                       originplace: String = "EDI",
                       destinationplace: String = "LHR",
                       outbounddate: String = "2019-02-25",
                       inbounddate: String = "2019-02-26",
                       adults: String = "1",
                       children: String = "0",
                       infants: String = "0",
                       apikey: String,
                        success: @escaping ((String) -> Void), error: @escaping ((NSError?, Int) -> Void)) {
        let headers = [
            "X-Forwarded-For": "8.8.8.8",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "cabinclass": cabinclass,
            "country": country,
            "currency": currency,
            "locale": locale,
            "locationSchema":locationSchema,
            "originplace":originplace,
            "destinationplace":destinationplace,
            "outbounddate":outbounddate,
            "inbounddate":inbounddate,
            "adults":adults,
            "children":children,
            "infants":infants,
            "apikey":apikey
        ]

        Alamofire.request(createSessionUrl, method: .post, parameters: parameters, encoding:  URLEncoding(), headers: headers).validate(statusCode: 200..<300).responseJSON { (responseJson) in
            switch responseJson.result {
            case .success:
                if let headers = responseJson.response?.allHeaderFields,
                    let urlWithSessionKey = headers["Location"] as? String {
                    success(urlWithSessionKey)
                }
                else {
                    error(nil, 0)
                }
            case .failure:
                error(nil, responseJson.response?.statusCode ?? 0)
            }
        }
    }
}
