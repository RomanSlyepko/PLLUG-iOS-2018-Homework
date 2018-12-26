//
//  ArtistInfoCell.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/25/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import UIKit

class ArtistInfoCell: UITableViewCell {

    static let identifier: String = "ArtistInfoCell"
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var onTourLabel: UILabel!
    @IBOutlet weak var upcomingEventsButton: UIButton!
    
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    var delegate: EventsButtonDelegate?
    
    @IBAction func eventsButtonClicked(_ sender: UIButton) {
        delegate?.eventsButtonTapped(sender: sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureViews() {
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
        artistImage.layer.cornerRadius = 6
        artistImage.layer.masksToBounds = true
        artistImage.image = UIImage(named: "noimage")
        artistImage.contentMode = .scaleToFill
    }
    
    func setDataFromModel(_ model: ArtistModel, numberOfEvents: Int) {
        artistName.text = model.displayName
        if let onTourString = model.onTourUntil {
            onTourLabel.text = "On tour until: \(onTourString)"
        } else {
            onTourLabel.text = "On tour: No"
        }
        upcomingEventsButton.setTitle("Upcoming events: \(numberOfEvents)", for: .normal)
        
        RequestManager.shared.getArtistImage(id: model.id) { image in
            if let image = image {
                //self.artistImage.image = image
                self.fadeIn(image: image)
            }
        }
    }
    
    func fadeIn(image: UIImage) {
        let artistImageSubview = UIImageView(image: image)
        artistImageSubview.contentMode = artistImage.contentMode
        artistImageSubview.frame = artistImage.bounds
        artistImageSubview.alpha = 0.0
        artistImage.addSubview(artistImageSubview)
        
        UIView.animate(withDuration: 0.75, animations: {
            artistImageSubview.alpha = 1.0
        }, completion: {
            finished in
            //self.artistImage.image = image
            self.artistImage.image = self.mergeImages(imageView: artistImageSubview)
            artistImageSubview.removeFromSuperview()
        })
    }
    
    func mergeImages(imageView: UIImageView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(imageView.frame.size, false, 0.0)
        imageView.superview!.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

protocol EventsButtonDelegate {
    func eventsButtonTapped(sender: UIButton)
}
