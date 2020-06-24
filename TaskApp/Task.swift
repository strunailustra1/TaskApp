//
//  Task.swift
//  TaskApp
//
//  Created by Наталья Мирная on 08.06.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import RealmSwift

class Task: Object {
    @objc dynamic var note = ""
    @objc dynamic var created = Date()
    @objc dynamic var dueDate = Date()
    @objc dynamic var isComplete = false
    @objc dynamic var taskListName: TaskList!
}
