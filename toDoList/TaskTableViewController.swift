//
//  TaskTableViewController.swift
//  toDoList
//
//  Created by Erick Lui on 7/12/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import UIKit
import CoreData

class TaskTableViewController: UITableViewController {
  
  var tasks = [ToDoList]()
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
    
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchTasks()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  func fetchTasks() {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoList")
    do {
      let result = try context.fetch(request)
      tasks = result as! [ToDoList]
    } catch {
      print("\(error)")
    }
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
    cell.taskLabel?.text = tasks[indexPath.row].task
    cell.dateLabel?.text = tasks[indexPath.row].date
    cell.descripLabel?.text = tasks[indexPath.row].descrip
    
    if tasks[indexPath.row].checked {
      cell.accessoryType = .checkmark
    } else { cell.accessoryType = .none }
//    print(tasks[indexPath.row].checked)
    return cell
  }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let newCheck = !tasks[indexPath.row].checked
    tasks[indexPath.row].checked = !tasks[indexPath.row].checked
    if let cell = tableView.cellForRow(at: indexPath) {
      if tasks[indexPath.row].checked {
        cell.accessoryType = .checkmark
      } else { cell.accessoryType = .none }
    }
    do { try context.save() }
    catch { print("\(error)") }
  }
  
  @IBAction func unwindToTaskTableViewController(segue: UIStoryboardSegue) {
    let controller = segue.source as! NewTaskViewController
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy"
    let strDate = dateFormatter.string(from: controller.datePicker.date)
    
    let task = NSEntityDescription.insertNewObject(forEntityName: "ToDoList", into: context) as! ToDoList
    task.task = controller.taskTextField.text!
    task.date = strDate
    task.descrip = controller.descrTextView.text!
    task.checked = false
    tasks.append(task)
    
    do {
      try context.save()
    } catch {
      print("\(error)")
    }
    
    tableView.reloadData()
  }
}
