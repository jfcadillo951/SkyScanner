//
//  Agent.swift
//  SkyScanner
//
//  Created by Nisum on 2/1/19.
//  Copyright © 2019 SkyScanner. All rights reserved.
//

import UIKit
import ObjectMapper

class Agent: Mappable {
    var id: Int?
    var name: String?
    var imageUrl: String?
    var status: String?
    var optimisedForMobile: Bool?
    var type: String?

    init() {

    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id                   <-      map["Id"]
        name                 <-      map["Name"]
        imageUrl             <-      map["ImageUrl"]
        status               <-      map["Status"]
        optimisedForMobile   <-      map["OptimisedForMobile"]
        type                 <-      map["Type"]
    }
}
