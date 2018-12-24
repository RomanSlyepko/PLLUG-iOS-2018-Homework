//
//  Alert.swift
//  SongKick
//
//  Created by Roman on 12/10/18.
//  Copyright © 2018 Roman. All rights reserved.
//

import UIKit

class Alert {
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
    
    static func showErrorAlert(on vc: UIViewController, message: String) {
        showBasicAlert(on: vc, with: "Error occured", message: message)
    }
}
