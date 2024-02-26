//
//  CoreDataManager.swift
//  CoreDataTest
//
//  Created by t2023-m0041 on 2/26/24.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    // 싱글톤
    static var shared = CoreDataManager()
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    var context: NSManagedObjectContext {
        return self.persistentContainer!.viewContext
    }
    
    let request = Todo.fetchRequest()
    
    func createTodo(title: String, place: String?, dueDate: Date?, dueTime: Date, isCompleted: Bool, timeAlarm: Bool, placeAlarm: Bool, category: Category?) {
        let newTodo = Todo(context: context)
        newTodo.id = UUID()
        newTodo.title = title
        newTodo.place = place
        newTodo.dueDate = dueDate
        newTodo.dueTime = dueTime
        newTodo.isCompleted = isCompleted
        newTodo.timeAlarm = timeAlarm
        newTodo.placeAlarm = placeAlarm
        newTodo.category = category
        
        do {
            try context.save()
        } catch {
            context.rollback()
            print("오류가 발생하여 투두 생성에 실패하였습니다. \(error.localizedDescription)")
        }
    }
}
