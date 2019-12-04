//
//  Drink.swift
//  DrinkDemo_pt
//
//  Created by Kao on 2019/11/15.
//  Copyright © 2019 Kao Che. All rights reserved.
//

import Foundation

struct Drink:Codable {
    var name:String
    var ice:String
    var suger:String
    var remark:String
    var price:String
    var total:String
}

struct DrinkData:Codable {
    var data:Drink
}
