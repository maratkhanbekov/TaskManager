//
//  ViewController.swift
//  TaskManager
//
//  Created by Marat Khanbekov on 02.01.2021.
//

import UIKit

class TaskViewController: UIViewController {
    
    let rootView = TaskView()
    var tasks: [Task]?
    var task: Task?
    
    override func loadView() {
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.rootView.tableView.reloadData()
        
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        rootView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        super.viewDidLoad()
    }
    
    @objc
    func addTask() {
        let alert = UIAlertController(title: "Новая задача", message: "Введите название", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            let task = Task(name: textField.text!)
            self.task?.subtasks.append(task)
            self.rootView.tableView.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

