//
//  Extensions.swift
//  Library
//
//  Created by Denys White on 10/30/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func newConstrain(identifier: String, const : CGFloat){
            for constraint in self.view.constraints{
                if constraint.identifier == identifier {
                    constraint.constant = const
                }
            }
        view.layoutIfNeeded()
    }
    
    func alert(title: String?, message: String?, button: String?, action: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
