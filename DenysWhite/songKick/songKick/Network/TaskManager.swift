//
//  TaskManager.swift
//  songKick
//
//  Created by Denys White on 12/27/18.
//  Copyright © 2018 Denys White. All rights reserved.
//

import Foundation

class TaskManager {

    init(){}

    func cancelTask(task: URLSessionTask?) {
        task?.cancel()
    }
}
