//
//  Perfomance.swift
//  SongKick
//
//  Created by user on 12/25/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

struct Performance: Codable {
    let id: Double
    let displayName: String?
    let billing: Billing
    let billingIndex: Double
    let artist: Artist
}
