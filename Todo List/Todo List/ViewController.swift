//
//  ViewController.swift
//  Todo List
//
//  Created by t2023-m0041 on 12/12/23.
//

import UIKit

struct Todo {
    var title: String
    var isCompleted: Bool
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var todoTable: UITableView!
    var todos:[Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todos = [
            Todo(title: "운동하기", isCompleted: false),
            Todo(title: "빨래하기", isCompleted: true),
            Todo(title: "설거지하기", isCompleted: false)
        ]
        
        todoTable.dataSource = self
        todoTable.delegate = self
        todoTable.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        
        cell.accessoryType = todo.isCompleted ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todos[indexPath.row].isCompleted.toggle()
        tableView.reloadData()
    }
    
        @IBAction func addTodoButton(_ sender: Any) {
            let alertController = UIAlertController(title: "할일 추가하기", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "할일을 입력하세요."
            }
            
            let addAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
                guard let self = self else { return }
                if let text = alertController.textFields?.first?.text, !text.isEmpty {
                    let newTodo = Todo(title: text, isCompleted: false)
                    self.todos.append(newTodo)
                    self.todoTable.reloadData()
                }
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alertController.addAction(addAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
    }
}

