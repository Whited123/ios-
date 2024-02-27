//
//  ViewController.swift
//  CoreDataTest
//
//  Created by t2023-m0041 on 2/22/24.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let coreDataManager = CoreDataManager.shared
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    private lazy var floatingButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .systemPink
        config.image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        button.configuration = config
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        return button
    }()
    private let todoButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .systemPink
        config.image = UIImage(systemName: "pencil")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        button.configuration = config
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(didTapTodoAdd), for: .touchUpInside)
        return button
    }()
    private let categoryButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .systemPink
        config.image = UIImage(systemName: "doc")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        button.configuration = config
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(didTapCategoryAdd), for: .touchUpInside)
        return button
    }()
    
    private var isActive: Bool = false {
        didSet {
            showActionButtons()
        }
    }
    
    private var animation: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 60 - 8 - 20, y: view.frame.size.height - 60 - 8 - 40, width: 60, height: 60)
        todoButton.frame = CGRect(x: view.frame.size.width - 60 - 8 - 20, y: view.frame.size.height - 60 - 80 - 8 - 40, width: 60, height: 60)
        categoryButton.frame = CGRect(x: view.frame.size.width - 60 - 8 - 20, y: view.frame.size.height - 60 - 160 - 8 - 40, width: 60, height: 60)
    }
    
    private func setUI() {
        title = "코어데이터 테스트"
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
        view.addSubview(floatingButton)
        view.addSubview(todoButton)
        view.addSubview(categoryButton)
    }
    
    @objc private func filterButtonTapped() {
        let categories = coreDataManager.readCategory()
        
        let alertController = UIAlertController(title: "카테고리 선택", message: nil, preferredStyle: .actionSheet)
        
        for category in categories {
            let action = UIAlertAction(title: category.title, style: .default) { [weak self] _ in
                guard let self = self else { return }

                self.tableView.reloadData()
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func didTapFloatingButton() {
        isActive.toggle()
    }
    
    private func showActionButtons() {
        popButtons()
        rotateFloatingButton()
    }
    
    private func popButtons() {
        if isActive {
            todoButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            categoryButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.todoButton.layer.transform = CATransform3DIdentity
                self.todoButton.alpha = 1.0
                self.categoryButton.layer.transform = CATransform3DIdentity
                self.categoryButton.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.15, delay: 0.2, options: []) { [weak self] in
                guard let self = self else { return }
                self.todoButton.layer.transform = CATransform3DMakeScale(1, 1, 1)
                self.todoButton.alpha = 0.0
                self.categoryButton.layer.transform = CATransform3DMakeScale(1, 1, 1)
                self.categoryButton.alpha = 0.0
            }
        }
    }
    
    private func rotateFloatingButton() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let fromValue = isActive ? 0 : CGFloat.pi / 4
        let toValue = isActive ? CGFloat.pi / 4 : 0
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 0.3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        floatingButton.layer.add(animation, forKey: nil)
    }
    
    @objc private func didTapTodoAdd() {
        let alert = UIAlertController(title: "새로운 투두 추가", message: "투두를 추가하세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "제목"
        }
        alert.addTextField { textField in
            textField.placeholder = "장소 (선택)"
        }
        alert.addTextField { textField in
            textField.placeholder = "마감날짜 (선택)"
            textField.inputView = UIDatePicker()
        }
        alert.addTextField { textField in
            textField.placeholder = "마감시간"
            textField.inputView = UIDatePicker()
        }
        alert.addTextField { textField in
            textField.placeholder = "카테고리"
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            guard let title = alert.textFields?[0].text, !title.isEmpty else { return }
            let place = alert.textFields?[1].text
            let dueDateText = alert.textFields?[2].text
            let dueTimeText = alert.textFields?[3].text
            let categoryName = alert.textFields?[4].text
            
            var dueDate: Date?
            var dueTime: Date?
            
            if let dueDateText = dueDateText, !dueDateText.isEmpty {
                dueDate = self.getDateFromString(dateString: dueDateText)
            }
            if let dueTimeText = dueTimeText, !dueTimeText.isEmpty {
                dueTime = self.getTimeFromString(timeString: dueTimeText)
            }
            
            let category = self.getCategoryName(categoryName)
            
            self.coreDataManager.createTodo(title: title, place: place, dueDate: dueDate, dueTime: dueTime ?? Date(), isCompleted: false, timeAlarm: false, placeAlarm: false, category: category)
            self.tableView.reloadData()
        }))
        
        present(alert, animated: true)
    }
    
    private func getCategoryName(_ name: String?) -> Category? {
        guard let name = name else { return nil }
        let categories = CoreDataManager.shared.readCategory()
        return categories.first { $0.title == name }
    }
    
    private func getDateFromString(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
    
    private func getTimeFromString(timeString: String) -> Date? {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH : mm"
        return timeFormatter.date(from: timeString)
    }
    
    @objc private func didTapCategoryAdd() {
        let alert = UIAlertController(title: "새로운 카테고리 추가", message: "카테고리를 추가하세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "제목"
        }
        alert.addTextField { textField in
            textField.placeholder = "색깔"
        }
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            guard let title = alert.textFields?[0].text, !title.isEmpty else { return }
            let color = alert.textFields?[1].text
            
            self.coreDataManager.createCategory(title: title, color: color ?? "", todo: nil)
            self.tableView.reloadData()
        }))
        
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "투두 수정", message: "투두를 수정하세요.", preferredStyle: .alert)
        let todo = coreDataManager.readTodo()[indexPath.row]
        
        alert.addTextField { textField in
            textField.placeholder = "새로운 제목"
            textField.text = todo.title
        }
        
        alert.addTextField { textField in
            textField.placeholder = "새로운 장소 (선택)"
            textField.text = todo.place
        }
        
        alert.addTextField { textField in
            textField.placeholder = "새로운 날짜 (선택)"
            textField.text = todo.dueDate != nil ? self.getDateStringFromDate(date: todo.dueDate!) : ""
            textField.inputView = UIDatePicker()
        }
        
        alert.addTextField { textField in
            textField.placeholder = "새로운 시간"
            textField.text = todo.dueTime != nil ? self.getTimeStringFromDate(date: todo.dueTime!) : ""
            textField.inputView = UIDatePicker()
        }
        
        alert.addTextField { textField in
            textField.placeholder = "새로운 카테고리"
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            
            guard let newTitle = alert.textFields?[0].text, !newTitle.isEmpty else { return }
            let newPlace = alert.textFields?[1].text
            let newDateText = alert.textFields?[2].text
            let newTimeText = alert.textFields?[3].text
            let newCategory = alert.textFields?[4].text
            
            var newDate: Date?
            var newTime: Date?
            
            if let newDateText = newDateText, !newDateText.isEmpty {
                newDate = self.getDateFromString(dateString: newDateText)
            }
            if let newTimeText = newTimeText, !newTimeText.isEmpty {
                newTime = self.getTimeFromString(timeString: newTimeText)
            }
            
            let category = self.getCategoryName(newCategory)
            
            self.coreDataManager.updateTodo(todo: todo, newTitle: newTitle, newPlace: (newPlace ?? todo.place)!, newDate: newDate, newTime: newTime ?? Date(), newCompleted: todo.isCompleted, newTimeAlarm: todo.timeAlarm, newPlaceAlarm: todo.placeAlarm, newCategory: category)
            
            self.tableView.reloadData()
        }))
        
        present(alert, animated: true)
    }
    
    private func getDateStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    private func getTimeStringFromDate(date: Date) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let todos = CoreDataManager.shared.readTodo()
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let todos = coreDataManager.readTodo()
        
        let todo = todos[indexPath.row]
        
        cell.textLabel?.text = todo.title
        if let dueDate = todo.dueDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            cell.detailTextLabel?.text = "마감 날짜: \(dateFormatter.string(from: dueDate))"
        } else {
            cell.detailTextLabel?.text = "마감 날짜: 없음"
        }
        cell.detailTextLabel?.text = "장소: \(todo.place ?? "없음")"
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let todoDelete = coreDataManager.readTodo()[indexPath.row]
            coreDataManager.deleteTodo(todo: todoDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}




