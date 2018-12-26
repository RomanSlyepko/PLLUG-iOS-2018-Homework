//
//  EventInfoCell.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/25/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import UIKit
import MapKit

class EventInfoCell: UITableViewCell {

    static let identifier: String = "EventInfoCell"
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataFromModel(_ model: EventModel) {
        eventTitleLabel.text = model.displayName
        let location = "\(model.venue.displayName), \(model.location.city)"
        eventLocationLabel.text = location
    }
}
