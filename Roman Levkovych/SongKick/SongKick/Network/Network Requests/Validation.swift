//
//  Validation.swift
//  SongKick
//
//  Created by Roman on 12/23/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import Foundation

func validateArtist(_ text: String) -> String? {
    return text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
}
