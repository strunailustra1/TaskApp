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
    //  private var completedTasks: Results<Task>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortTasks()
        navigationController?.navigationBar.backItem?.title = currentList.name
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 96
        tableView.sectionHeaderHeight = 32
    }
    
    @IBAction func completeTask(_ sender: UIButton) {
        guard let taskCell = sender.superview?.superview?.superview as? TaskViewCell else { return }
        guard let indexPath = tableView.indexPath(for: taskCell) else { return }
        //   taskCell.doneButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        let task = currentTasks[indexPath.row]
        if indexPath.row == 0 {
            taskCell.doneButton.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        }
        else {
            taskCell.doneButton.setImage(UIImage(systemName: "circle"), for: .selected)
        }
        StorageManager.done(task: task)
        print(task)
        tableView.reloadData()
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  section == 0 ? currentTasks.count : completedTasks.count
        currentTasks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //  section == 0 ? "Current Tasks" : "Completed Tasks"
        "Current Tasks"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as! TaskViewCell
        // let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        let task = currentTasks[indexPath.row]
        cell.taskLabel.text = task.note
        cell.taskListLabel.text = currentList.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = currentTasks[indexPath.row]
        print(task)
        print("didSelectRowAt")
        performSegue(withIdentifier: "editTask", sender: task)
    }
    
    private func sortTasks() {
        currentTasks = currentList.tasks.filter("isComplete = false")
        // completedTasks = currentList.tasks.filter("isComplete = true")
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTask" {
            let newTaskVC = segue.destination as! NewTaskViewController
            let task = sender as? Task
            newTaskVC.task = task
        }  else if segue.identifier == "addNewTask" { 
            let newTaskVC = segue.destination as! NewTaskViewController
            let newTask = sender as? Task
            newTaskVC.newTaskView.text = "ty"
            newTaskVC.taskListLabel.text = "rt"
            newTaskVC.task = newTask
        }
    }
}
