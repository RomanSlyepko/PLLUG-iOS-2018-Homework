//
//  SearchCell.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/8/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    static let identifier = "SearchCell"
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var artistImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureImageView()
    }
    
    func configureImageView() {
        artistImage.layer.cornerRadius = self.artistImage.frame.size.width / 2
        artistImage.layer.borderWidth = 1
        artistImage.layer.borderColor = #colorLiteral(red: 0.8595529199, green: 0.8596976399, blue: 0.8595339656, alpha: 1)
        artistImage.clipsToBounds = true
        artistImage.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataFromModel(_ model: ArtistModel) {
        artistName.text = model.displayName
        
        //I'm aware this is a terrible way to do this, but I kind of ran out of time to fix this
        let manager = RequestManager()
        manager.getArtistImage(id: model.id) { image in
            if let image = image {
                self.artistImage.image = image
            }
        }
        
    }
    
}


