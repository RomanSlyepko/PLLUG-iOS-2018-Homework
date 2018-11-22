//
//  ViewController.swift
//  hw_Weather
//
//  Created by Alex Chaku on 11/16/18.
//  Copyright © 2018 Alex Chaku. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dataManager = DataManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.getUVIndex(withLat: "39.875160", andLong: "20.006639", completion: { (result) in
            print(result)
            print()
        }) { (error) in
            print("Error 2: \(error.localizedDescription)")
        }
        
        dataManager.getCurrentWeather(withLat: "-22.906847", andLong: "-43.172897", completion: { (result) in
            print(result)
            print()
        }) { (error) in
            print("Error 3: \(error.localizedDescription)")
        }
        
        dataManager.getFututeWeather(forCity: "Lviv", completion: { (result) in
            print(result)
            print()
        }) { (error) in
            print("Error 4: \(error.localizedDescription)")
        }
    }
}

