//
//  CoreDataController.swift
//  ProfileDesignView
//
//  Created by t2023-m0041 on 2/1/24.
//

import UIKit
import CoreData

class CoreDataController: UIViewController {
    
    func createTask(title: String, isCompleted: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        let task = NSManagedObject(entity: entity, insertInto: managedContext)
        
        task.setValue(UUID(), forKeyPath: "id")
        task.setValue(title, forKeyPath: "title")
        task.setValue(Date(), forKeyPath: "createDate")
        task.setValue(Date(), forKeyPath: "modifyDate")
        task.setValue(isCompleted, forKeyPath: "isCompleted")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func readTasks() -> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            let tasks = try managedContext.fetch(fetchRequest)
            return tasks
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func updateTask(task: NSManagedObject, title: String, isCompleted: Bool) {
        task.setValue(title, forKey: "title")
        task.setValue(isCompleted, forKey: "isCompleted")
        task.setValue(Date(), forKey: "modifyDate")
        
        do {
            try task.managedObjectContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteTask(task: NSManagedObject) {
        task.managedObjectContext?.delete(task)
        
        do {
            try task.managedObjectContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
