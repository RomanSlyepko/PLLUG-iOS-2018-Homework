//
//  ArrayExtension.swift
//  songKick
//
//  Created by Denys White on 12/7/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    mutating func delete(_ element: Element) {
        
        self = self.filter { $0 != element }
        
    }
    
}
