//
//  NewTaskViewController.swift
//  TaskApp
//
//  Created by Наталья Мирная on 01.06.2020.
//  Copyright © 2020 Наталья Мирная. All rights reserved.
//

import UIKit
import RealmSwift

class NewTaskViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var addTask: UIButton!
    @IBOutlet weak var newTaskView: UITextView!
    @IBOutlet weak var taskListLabel: UILabel!
    
    var task: Task!
    var tasklist: TaskList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newTaskView.text = task.note
        taskListLabel.text = task.taskListName.name
        newTaskView.textColor = UIColor.gray
        newTaskView.returnKeyType = .done
        newTaskView.delegate = self
        
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func editTask(_ sender: UIButton) {
        guard let taskContent = newTaskView.text, !taskContent.isEmpty else { return }
        if let task = task {
            StorageManager.edit(task: task, with: taskContent)
            print(taskContent)
        } else {
            let task = Task()
            task.note = taskContent
            StorageManager.save(task, in: tasklist)
        }
    }
    
    // MARK: - UITextViewDelegates
    func textViewDidBeginEditing(_ textView: UITextView) {
        if newTaskView.text == task.note {
            newTaskView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    // MARK: - Navigation
    //     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "" {
    //        }
    //     }
}
