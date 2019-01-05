//
//  SongKickDateFormatter.swift
//  SongKick
//
//  Created by Roman on 12/27/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

class SKDateFormatter: DateFormatter {
    private var serverDateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }

    private var clientDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }
}
