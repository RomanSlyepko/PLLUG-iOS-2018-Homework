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
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var artistImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureImageView()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        if let viewWithTag = self.artistImage.viewWithTag(100) {
//            viewWithTag.removeFromSuperview()
//        }
        artistImage.image = UIImage(named: "noimage")
    }
    
    func configureImageView() {
        artistImage.layer.cornerRadius = self.artistImage.frame.size.width / 2
        artistImage.layer.borderWidth = 1
        artistImage.layer.borderColor = #colorLiteral(red: 0.8595529199, green: 0.8596976399, blue: 0.8595339656, alpha: 1)
        artistImage.clipsToBounds = true
        artistImage.contentMode = .scaleToFill
        artistImage.image = UIImage(named: "noimage")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataFromModel(_ model: ArtistModel) {
        artistName.text = model.displayName
        
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


