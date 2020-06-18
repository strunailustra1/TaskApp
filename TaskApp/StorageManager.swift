//
//  StorageManager.swift
//  TaskApp
//
//  Created by Наталья Мирная on 08.06.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func save(_ tasklist: TaskList) {
        try! realm.write{
            realm.add(tasklist)
        }
    }
    
    static func save(_ task: Task, in tasklist: TaskList) {
        try! realm.write{
            tasklist.tasks.append(task)
        }
    }
    
    static func delete(_ tasklist: TaskList) {
        try! realm.write{
            let tasks = tasklist.tasks
            realm.delete(tasks)
            realm.delete(tasklist)
        }
    }
    
    static func edit(tasklist: TaskList, with newname: String) {
        try! realm.write {
            tasklist.name = newname
        }
    }
    
    static func edit(task: Task, with newname: String) {
        try! realm.write{
            task.content = newname
        }
    }
}
