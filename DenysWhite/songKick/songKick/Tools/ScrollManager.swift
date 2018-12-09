//
//  ScrollManager.swift
//  songKick
//
//  Created by Denys White on 12/9/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    
    func scrollToTop(){
        DispatchQueue.main.async {
            if !self.visibleCells.isEmpty{
                let indexPath = NSIndexPath(row: 0, section: 0)
                self.scrollToRow(at: indexPath as IndexPath, at: .top, animated: false)
            }
        }
    }
    
    func reloadDataAndScrollToTop(completion: @escaping ()->()){
        
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
            self.layoutIfNeeded()
            self.scrollToTop()
        })
        { _ in completion() }
    }
    
}
