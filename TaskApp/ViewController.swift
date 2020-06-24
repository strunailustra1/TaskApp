//
//  ViewController.swift
//  TaskApp
//
//  Created by Наталья Мирная on 29.05.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate {
    
    var tasklists: Results<TaskList>!
    
    @IBOutlet weak var addNewTask: UIButton!
    
    @IBOutlet weak var taskListsTableView: UITableView!
    //  var tasks = ["Life happens.", "Shit happens.", "And it happens a lot.", "To a lot of people."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasklists = realm.objects(TaskList.self)
        let taskList1 = TaskList()
        taskList1.name = "About life"
        
        let task1 = Task()
        task1.note = "Life happens."
        task1.isComplete = false
        task1.taskListName = taskList1
        
        let taskList2 = TaskList()
        taskList2.name = "Shit happens."
        
        let task2 = Task()
        task2.isComplete = false
        task2.note = "And it happens a lot."
        task2.taskListName = taskList2
        
        let task3 = Task()
        task3.isComplete = false
        task3.note = "To a lot of people."
        task3.taskListName = taskList1
        
        StorageManager.save(taskList1)
        StorageManager.save(taskList2)
        StorageManager.save(task1, in: taskList1)
        StorageManager.save(task2, in: taskList2)
        StorageManager.save(task3, in: taskList1)
        
        setNavigationTheme()
        setShadowButton()
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        taskListsTableView.reloadData()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        taskListsTableView.reloadData()
//    }
    
    func setShadowButton() {
        addNewTask.layer.shadowRadius = 10
        addNewTask.layer.shadowOffset = CGSize(width: 5, height: 5)
        addNewTask.layer.shadowOpacity = 0.5
        addNewTask.layer.shadowColor = UIColor(red: 158/255, green: 138/255, blue: 175/255, alpha: 1.0).cgColor
        addNewTask.layer.shadowPath = UIBezierPath(roundedRect: addNewTask.bounds, cornerRadius: 10.0).cgPath
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasklists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskList", for: indexPath) as! TaskListViewCell
        let tasklist = tasklists[indexPath.row]
        cell.taskLabel.text = tasklist.name
        cell.numberOfTasks.text = "\(tasklist.tasks.filter("isComplete = false").count)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tasklist = tasklists[indexPath.row]
        performSegue(withIdentifier: "showTasks", sender: tasklist)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTasks" {
            let tasksVC = segue.destination as! TasksViewController
            tasksVC.currentList = sender as? TaskList
        }
    }
    
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        let footerView = UIView()
    //        footerView.frame = CGRect(x: 280, y: 480, width: self.view.frame.width, height:
    //            60)
    //        footerView.backgroundColor = .white
    //        button.frame = CGRect(x: self.view.frame.width - 70, y: 2, width: 55, height: 55)
    //        button.layer.cornerRadius = button.frame.width / 2
    //        let image = UIImage(systemName: "square.and.pencil")
    //        button.setBackgroundImage(image, for: .normal)
    //        button.tintColor = UIColor(red: 158/255, green: 138/255, blue: 175/255, alpha: 1.0)
    //        footerView.addSubview(button)
    //        return footerView
    //
    //    }
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let  off = scrollView.contentOffset.y
    //        button.frame = CGRect(x: 280, y:   off + 480, width: button.frame.size.width, height: button.frame.size.height)
    //    }
    //    }
    //
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        60.0
    //    }
    
    @IBAction func addTaskButton(_ sender: UIButton) {
        
    }
    
    private func setNavigationTheme() {
        navigationController?.navigationBar.barTintColor =  UIColor(red: 158/255, green: 138/255, blue: 175/255, alpha: 1.0)
    }
    // override var presentationController: UIPresentationController?
}
