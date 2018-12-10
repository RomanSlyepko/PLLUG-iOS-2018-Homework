//
//  SingerDetailViewController.swift
//  SongKick
//
//  Created by user on 12/6/18.
//  Copyright © 2018 Volodymyr Chorniak. All rights reserved.
//

import UIKit

enum AlertParam: String {
    case titleError = "This artist has already been added"
    case messageError = "You can not add two identical artists to your list of favorites"
    case titleSucces = "Artist added"
    case messageSucces = "The artist has been successfully added to your favorite list"
}

class SingerDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var tourLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var singer: Artist!
    var isFavorite = false

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = singer.displayName
        idLabel.text = "id: " + String(singer.id)
        tourLabel.text = singer.onTourUntil != nil ? "On tour until \(String(describing: singer.onTourUntil!))" : "Not currently on tour"
        
        if isFavorite {
            addButton.isHidden = true
        }
    }
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        if !FavoriteArtist.sharedArtist.saveArtist(artist: singer) {
            showAlert(withTitle: AlertParam.titleError, andMessage: AlertParam.messageError)
        } else {
            showAlert(withTitle: AlertParam.titleSucces, andMessage: AlertParam.messageSucces)
        }
    }
    
    func showAlert(withTitle title: AlertParam, andMessage message: AlertParam) {
        let alert = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
