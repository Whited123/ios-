//
//  ViewController.swift
//  test
//
//  Created by t2023-m0041 on 1/4/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        deleteData()
        getData()
    }

    // 데이터 쓰기 (Create)
    func saveData() {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let newCar = Car(context: context)
        
        newCar.id = UUID()
        newCar.name = "benz"
        
        try? context.save()
    }
    
    // 데이터 읽기 (Read)
    func getData() {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = Car.fetchRequest()
        let cars = try? context.fetch(request)
        
        print(cars)
    }
    
    // 데이터 수정 (Update)
    func updateData() {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = Car.fetchRequest()
        guard let cars = try? context.fetch(request) else { return }
        
        let filteredCard = cars.filter { $0.name == "benz" }
        
        for car in filteredCard {
            car.name = "tesla"
        }
        
        try? context.save()
    }
    
    // 데이터 삭제 (Delete)
    func deleteData() {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        let request = Car.fetchRequest()
        guard let cars = try? context.fetch(request) else { return }
        
        let filteredCard = cars.filter { $0.name == "tesla" }
        
        for car in filteredCard {
            context.delete(car)
        }
        
        try? context.save()
    }
}

