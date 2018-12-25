//
//  Observer.swift
//  hw-SongKick
//
//  Created by Roman Mnykh on 12/10/18.
//  Copyright © 2018 Roman Mnykh. All rights reserved.
//

import Foundation

protocol ObservableData: class {
    func addObserver(_ observer: DataObserver)
    func removeObserver(_ observer: DataObserver)
    func notify()
}

protocol DataObserver: class {
    func notifyDataChanged()
}
