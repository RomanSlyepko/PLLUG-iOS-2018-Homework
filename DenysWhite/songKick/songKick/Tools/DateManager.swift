//
//  DateManager.swift
//  songKick
//
//  Created by Denys White on 12/25/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

enum DateManager {
    
    private static let serverDateAndTimeFormater: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
        return formatter
    }()
    
    private static let serverDateFormater: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private static let displayDateAndTimaFormater: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter
    }()
    
    private static let displayDateFormater: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    enum DateType {
        case fullFromServer
        case onlyDateFromServer
        case fullToDisplay
        case onlyDateToDisplay
    }
    
    static func date(from string: String?, type: DateType) -> Date? {
        
        guard let string = string else { return nil }
        return formater(for: type).date(from: string)
    }
    
    static func string(from date: Date?, type: DateType) -> String? {
        
        guard let date = date else { return nil }
        return formater(for: type).string(from: date)
    }
    
    private static func formater(for type: DateType) -> DateFormatter {
        switch type {
        case .fullFromServer:
            return serverDateAndTimeFormater
        case .fullToDisplay:
            return displayDateAndTimaFormater
        case .onlyDateFromServer:
            return serverDateFormater
        case .onlyDateToDisplay:
            return displayDateFormater
        }
    }
    
}
