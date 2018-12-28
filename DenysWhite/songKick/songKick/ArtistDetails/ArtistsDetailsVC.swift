//
//  ArtistsDetailsVC.swift
//  songKick
//
//  Created by Denys White on 12/24/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import UIKit

class ArtistsDetailsVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tourInfoLabel: UILabel!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var currentArtist: Artist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        nameLabel.text = currentArtist.displayName
        
        if let tour = currentArtist.onTourUntilString {
            tourInfoLabel.text = "On tour:\nuntil \(tour)"
        }else{
            tourInfoLabel.text = "On tour: no"
        }
        
        if currentArtist.onTourUntilString == nil || currentArtist.identifier.isEmpty {
            eventsButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            eventsButton.isEnabled = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if imageView.image != nil { return }
        ImageService.shared.downloadImage(artistID: String(currentArtist.id)) { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.spinner.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EventsTVC{
            destination.currentArtist = currentArtist
        }
    }
}
