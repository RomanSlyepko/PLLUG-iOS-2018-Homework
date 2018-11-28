//
//  Current.swift
//  WhiteUmbrella
//
//  Created by Denys White on 11/28/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

struct Current: Codable{
    var weather : [Weather]
    var main : Main
    var wind : Wind
    var clouds : Clouds
}
struct Weather: Codable {
    var description : String
}
struct Main: Codable {
    var temp : Double
}
struct Wind: Codable {
    var speed : Double
}
struct Clouds: Codable {
    var all : Int8
}
