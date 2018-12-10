//
//  ResultPage.swift
//  SongKick
//
//  Created by user on 12/7/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import Foundation

struct ResultsPage: Codable {
    let status: String
    let results: Results
    let perPage, page, totalEntries: Int
}
