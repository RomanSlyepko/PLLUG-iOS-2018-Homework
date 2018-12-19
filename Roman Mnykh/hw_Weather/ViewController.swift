//
//  ViewController.swift
//  hw_Weather
//
//  Created by Roman Mnykh on 11/16/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import UIKit

// -------------------------------------
// MARK: - ViewController
// -------------------------------------
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ...
        
        Network.shared.requestData(of: .weatherInCity("Lviv"), as: WeatherData.self) {
            switch $0 {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
