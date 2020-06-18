//
//  TasksViewController.swift
//  TaskApp
//
//  Created by Наталья Мирная on 09.06.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit
import RealmSwift

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate {
    
    var currentList: TaskList!
    private var currentTasks: Results<Task>!
    private var completedTasks: Results<Task>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortTasks()
        navigationController!.navigationBar.topItem!.title = currentList.name
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? currentTasks.count : completedTasks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Current Tasks" : "Completed Tasks"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as! TaskViewCell
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        cell.taskLabel.text = task.content
        cell.taskListLabel.text = currentList.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = currentTasks[indexPath.row]
    //    let task = currentList.tasks[indexPath.row]
        print(task)
        print("didSelectRowAt")
        performSegue(withIdentifier: "editTask", sender: task)
    }

    private func sortTasks() {
        currentTasks = currentList.tasks.filter("isComplete = false")
        completedTasks = currentList.tasks.filter("isComplete = true")
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTask" {
            let newTaskVC = segue.destination as! NewTaskViewController
            let task = sender as? Task
            newTaskVC.task = task
        }
//        if segue.identifier == "editTask" {
//            let newTaskVC = segue.destination as! NewTaskViewController
//            let taskList = sender as? TaskList
//            newTaskVC.tasklist = taskList
//        }
    }
}
