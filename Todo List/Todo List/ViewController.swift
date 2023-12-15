//
//  ViewController.swift
//  Todo List
//
//  Created by t2023-m0041 on 12/12/23.
//

import UIKit
import PhotosUI

struct Todo {
    var title: String
    var isCompleted: Bool
    var image: UIImage?
    var dueDate: Date?
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var todoTable: UITableView!
    var todos:[Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todos = [
            Todo(title: "운동하기", isCompleted: false, image: nil, dueDate: Date()),
            Todo(title: "빨래하기", isCompleted: true, image: nil, dueDate: Date(timeIntervalSinceNow: 3600)),
            Todo(title: "설거지하기", isCompleted: false, image: nil, dueDate: Date(timeIntervalSinceNow: 7200))
        ]
        
        todoTable.dataSource = self
        todoTable.delegate = self
        todoTable.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
        
        todoTable.rowHeight = UITableView.automaticDimension
        todoTable.estimatedRowHeight = 60
        todoTable.separatorStyle = .singleLine
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        
        if let image = todo.image {
            cell.imageView?.image = image
        } else {
            cell.imageView?.image = nil
        }
        
        var content = cell.defaultContentConfiguration()
        content.text = todo.title
        content.secondaryText = todo.dueDate.map { DateFormatter.localizedString(from: $0, dateStyle: .medium, timeStyle: .short) } ?? ""
        
        cell.contentConfiguration = content
        
        cell.accessoryType = todo.isCompleted ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todos[indexPath.row].isCompleted.toggle()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
        @IBAction func addTodoButton(_ sender: Any) {
            let alertController = UIAlertController(title: "할일 추가하기", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "할일을 입력하세요."
            }
            
            let datePickerTextField = UITextField()
            datePickerTextField.placeholder = "시간을 입력하세요."
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .dateAndTime
            datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
            datePickerTextField.inputView = datePicker
            alertController.view.addSubview(datePickerTextField)
            
            let addAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
                guard let self = self,
                    let text = alertController.textFields?.first?.text, !text.isEmpty,
                      let date = datePickerTextField.inputView as? UIDatePicker else { return }
                    
                let newTodo = Todo(title: text, isCompleted: false, image: nil, dueDate: date.date)
                    self.todos.append(newTodo)
                    self.todoTable.reloadData()
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alertController.addAction(addAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        let datePickerTextField = sender.superview?.subviews.compactMap { $0 as? UITextField }.first
        datePickerTextField?.text = formatter.string(from: sender.date)
    }
}

