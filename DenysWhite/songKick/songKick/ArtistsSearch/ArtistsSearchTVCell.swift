//
//  ArtistsSearchTVCell.swift
//  songKick
//
//  Created by Denys White on 12/7/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class ArtistsSearchTVCell: UITableViewCell {

    @IBOutlet weak var ArtistNameLabel: UILabel!
    @IBOutlet weak var favouriteCheckerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var artist: Artist? {
        didSet{
            guard let artist = artist else { return }
            ArtistNameLabel.text = artist.displayName
        }
    }
    
}
