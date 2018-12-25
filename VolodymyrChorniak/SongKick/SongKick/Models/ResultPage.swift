//
//  ResultPage.swift
//  SongKick
//
//  Created by user on 12/25/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

struct ResultPage: Codable {
    let status: String
    let results: Result
    let perPage, page, totalEntries: Int
}
