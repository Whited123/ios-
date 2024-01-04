//
//  Car+CoreDataProperties.swift
//  test
//
//  Created by t2023-m0041 on 1/4/24.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?

}

extension Car : Identifiable {

}
