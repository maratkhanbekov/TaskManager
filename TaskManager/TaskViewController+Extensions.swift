//
//  TaskViewController+Extensions.swift
//  TaskManager
//
//  Created by Marat Khanbekov on 03.01.2021.
//

import UIKit

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TaskViewController()
        vc.task = self.task?.subtasks[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task?.subtasks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = self.task?.subtasks[indexPath.row]
        cell.textLabel!.text = "\(task!.name) - \(task!.numberOfSubTasks())"
        return cell
    }
}
