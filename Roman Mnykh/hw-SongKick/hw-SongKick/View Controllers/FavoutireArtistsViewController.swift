
//
//  FavoutireArtistsViewController.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/10/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import UIKit

class FavoutireArtistsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
        ArtistData.shared.addObserver(self)
        // Do any additional setup after loading the view.
        
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: SearchCell.identifier, bundle: nil), forCellReuseIdentifier: SearchCell.identifier)
        tableView.isHidden = true
    }
    
    private func configureNavigationBar() {
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = false
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

extension FavoutireArtistsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ArtistData.shared.favouriteArtists.count)
        return ArtistData.shared.favouriteArtists.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier) as! SearchCell
        let artistModel = ArtistData.shared.favouriteArtists[indexPath.row]
        cell.setDataFromModel(artistModel)
        return cell
    }
}

extension FavoutireArtistsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            ArtistData.shared.favouriteArtists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}

extension FavoutireArtistsViewController: DataObserver {
    func notifyDataChanged() {
        tableView.isHidden = false
        tableView.reloadData()
    }
}
