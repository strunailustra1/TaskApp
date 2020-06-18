//
//  Category.swift
//  TaskApp
//
//  Created by Наталья Мирная on 08.06.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import RealmSwift

class TaskList: Object {
    @objc dynamic var name = ""
    let tasks = List<Task>()
}
