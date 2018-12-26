//
//  FavouriteArtistsViewController2.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/23/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import UIKit

class FavouriteArtistsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ArtistData.shared.addObserver(self)
        configureCollectionView()
        configureNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? FavouriteArtistCell,
            let indexPath = collectionView.indexPath(for: cell),
            let destination = segue.destination as? EventsViewController {

            destination.artistModel = ArtistData.shared.favouriteArtists[indexPath.row]
        }
    }
    
    private func configureNavigationBar() {
        navigationController!.navigationBar.barStyle = .black
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func configureCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.register(UINib(nibName: FavouriteArtistCell.identifier, bundle: nil), forCellWithReuseIdentifier: FavouriteArtistCell.identifier)
    }
}

extension FavouriteArtistsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArtistData.shared.favouriteArtists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteArtistCell.identifier, for: indexPath as IndexPath) as! FavouriteArtistCell
        let artistModel = ArtistData.shared.favouriteArtists[indexPath.row]
        cell.setDataFromModel(artistModel)
        return cell
    }
    
}

extension FavouriteArtistsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemSize: CGFloat
        let orientation = UIApplication.shared.statusBarOrientation
        
        if(orientation == .landscapeLeft || orientation == .landscapeRight)
        {
            itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)) / 3.5
        } else {
            itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        }
        return CGSize(width: itemSize, height: itemSize)
    }

}

extension FavouriteArtistsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath)
        performSegue(withIdentifier: "showEvents", sender: cell)
    }
}

extension FavouriteArtistsViewController: DataObserver {
    func notifyDataChanged(_ action: Action) {
        if case Action.favouriteDidAdd = action {
            collectionView.reloadData()
        }
    }
}


