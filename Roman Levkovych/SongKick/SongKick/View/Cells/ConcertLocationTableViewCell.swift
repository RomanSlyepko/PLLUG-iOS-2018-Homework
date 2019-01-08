//
//  ConcertLocationTableViewCell.swift
//  SongKick
//
//  Created by Roman on 12/25/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit

class ConcertLocationTableViewCell: UITableViewCell {
    
    static let identifier = "ConcertLocationTableViewCell"
    @IBOutlet weak var concertName: UILabel!
    @IBOutlet weak var concertDate: UILabel!
    @IBOutlet weak var concertLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
