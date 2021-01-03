//
//  Task.swift
//  TaskManager
//
//  Created by Marat Khanbekov on 02.01.2021.
//

import Foundation


protocol TaskProtocol {
    var name: String { get }
}

class Task: TaskProtocol {
    var name: String
    var subtasks: [Task] = []
    
    init(name: String) {
        self.name = name
    }
    
    func numberOfSubTasks() -> Int {
        return subtasks.count
    }
}


