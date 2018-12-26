//
//  FavouriteArtistCell.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/23/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import UIKit

class FavouriteArtistCell: UICollectionViewCell {

    static let identifier = "FavouriteArtistCell"
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureImageView()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artistImage.image = UIImage(named: "noimage")
    }
    
    func configureImageView() {
        artistImage.image = UIImage(named: "noimage")
        artistImage.contentMode = .scaleToFill
    }
    
    func setDataFromModel(_ model: ArtistModel) {
        artistName.text = model.displayName
        RequestManager.shared.getArtistImage(id: model.id) { image in
            if let image = image {
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
