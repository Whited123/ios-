//
//  ViewController.swift
//  Todo List
//
//  Created by t2023-m0041 on 12/12/23.
//

import UIKit

struct Todo: Codable {
    var title: String
    var isCompleted: Bool
    var dueDate: Date?
    var category: String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var todoTable: UITableView!
    var todos:[Todo] = []
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTodos()
        // Do any additional setup after loading the view.
        
        setupImageView()
        loadCat()
        
        todoTable.dataSource = self
        todoTable.delegate = self
        todoTable.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
        
        todoTable.rowHeight = UITableView.automaticDimension
        todoTable.estimatedRowHeight = 60
        todoTable.separatorStyle = .singleLine
    }
    
    func loadCat() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self,
                  error == nil,
                  let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                  let imageURLString = json.first?["url"] as? String,
                  let imageURL = URL(string: imageURLString),
                  let imageData = try? Data(contentsOf: imageURL),
                  let image = UIImage(data: imageData) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        task.resume()
    }
    
    func setupImageView() {
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        fetchImage()
        hideImage()
    }
    
    func hideImage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            UIView.animate(withDuration: 1.0, animations: {
                self?.imageView.alpha = 0.0
            }, completion: { _ in
                self?.imageView.removeFromSuperview()
            })
        }
    }
    
    func loadTodos() {
        if let savedTodosData = UserDefaults.standard.data(forKey: "savedTodos") {
            let decoder = JSONDecoder()
            if let loadedTodos = try? decoder.decode([Todo].self, from: savedTodosData) {
                self.todos = loadedTodos
                self.todoTable.reloadData()
            }
        } else {
            setData()
        }
    }
    
    func fetchImage() {
        guard let url = URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self,
                  error == nil,
                  let data = data,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }.resume()
    }
    
    func setData() {
        todos = [
            Todo(title: "운동하기", isCompleted: false, dueDate: Date(), category: "운동"),
            Todo(title: "빨래하기", isCompleted: true, dueDate: Date(timeIntervalSinceNow: 3600), category: "생활"),
            Todo(title: "설거지하기", isCompleted: false, dueDate: Date(timeIntervalSinceNow: 7200), category: "생활")
        ]
        saveTodos()
    }
    
    func saveTodos() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(todos) {
            UserDefaults.standard.set(encoded, forKey: "savedTodos")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let uniqueCategories = Set(todos.map { $0.category })
        return uniqueCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = Array(Set(todos.map { $0.category }))[section]
        let todosInCategory = todos.filter { $0.category == category }
        return todosInCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        let category = Array(Set(todos.map { $0.category }))[indexPath.section]
        let todosInCategory = todos.filter { $0.category == category }
        let todo = todosInCategory[indexPath.row
        ]
        
        var content = cell.defaultContentConfiguration()
        content.text = todo.title
        content.secondaryText = todo.dueDate.map { DateFormatter.localizedString(from: $0, dateStyle: .medium, timeStyle: .short) } ?? ""
        
        cell.contentConfiguration = content
        
        cell.accessoryType = todo.isCompleted ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = todos[indexPath.row]
        
        let alertController = UIAlertController(title: "할일 수정 또는 삭제", message: "원하는 작업을 선택하세요.", preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "수정하기", style: .default) { [weak self] _ in
            self?.editTodo(at: indexPath)
        }
        
        let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { [weak self] _ in
            self?.deleteTodo(at: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let categories = todos.map { $0.category }
        let uniqueCategories = Array(Set(categories.filter { !$0.isEmpty }).sorted())
        guard section < uniqueCategories.count else {
            return nil
        }
        return uniqueCategories[section]
    }

    
    func editTodo(at indexPath: IndexPath) {
        let alertController = UIAlertController(title: "할일 수정", message: "새로운 할일을 입력하세요.", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "할일을 입력하세요."
        }
        
        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self] _ in
            guard let self = self,
                  let text = alertController.textFields?.first?.text, !text.isEmpty else { return }
            
            self.todos[indexPath.row].title = text
            self.saveTodos()
            self.todoTable.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func deleteTodo(at indexPath: IndexPath) {
        todos.remove(at: indexPath.row)
        saveTodos()
        todoTable.deleteRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.performBatchUpdates({
                self.todos.remove(at: indexPath.row)
                saveTodos()
                tableView.deleteRows(at: [indexPath], with: .fade)
            }, completion: nil)
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
        datePicker.addTarget(self, action: #selector(datePickerBuild), for: .valueChanged)
        datePickerTextField.inputView = datePicker
        alertController.view.addSubview(datePickerTextField)
        
        alertController.textFields?.last?.inputView = datePicker
        
        let addAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
            guard let self = self,
                  let text = alertController.textFields?.first?.text, !text.isEmpty,
                  let date = datePickerTextField.inputView as? UIDatePicker else { return }
            
            let newTodo = Todo(title: text, isCompleted: false, dueDate: date.date, category: "")
            self.todos.append(newTodo)
            
            if let categoryIndex = self.todos.firstIndex(where: { $0.category.isEmpty}) {
                self.todos[categoryIndex].category = newTodo.category
            }
            
            self.todoTable.reloadData()
            self.saveTodos()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    @objc func datePickerBuild(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        let datePickerTextField = sender.superview?.subviews.compactMap { $0 as? UITextField }.first
            datePickerTextField?.text = formatter.string(from: sender.date)
        
    }
}
