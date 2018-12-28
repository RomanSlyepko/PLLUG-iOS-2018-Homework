//
//  Alert.swift
//  songKick
//
//  Created by Denys White on 12/25/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    static let shared = Alert()
    
    func alert(title: String?, message: String?, button: String?, sender: UIViewController, action: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: nil))
        sender.present(alert, animated: true, completion: nil)
    }
    
    private init() {}
}
