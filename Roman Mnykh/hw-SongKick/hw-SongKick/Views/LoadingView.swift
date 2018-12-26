//
//  LoadingView.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/23/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    let spinner = UIActivityIndicatorView(style: .gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spinner.startAnimating()
        addSubview(spinner)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        spinner.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }

}
