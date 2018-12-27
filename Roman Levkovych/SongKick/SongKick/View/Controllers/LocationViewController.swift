//
//  LocationViewController.swift
//  SongKick
//
//  Created by Roman on 12/27/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {

    @IBOutlet weak var concertNameLabel: UILabel!
    @IBOutlet weak var concertLocationMapView: MKMapView!
    var concert: Location?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.concertNameLabel.text = concert?.city
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
