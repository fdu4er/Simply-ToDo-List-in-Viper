//
//  Task+CoreDataProperties.swift
//  ToDo_Viper
//
//  Created by Nik on 4/24/21.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var name: String?
    @NSManaged public var dateCreated: Date?

}

extension Task : Identifiable {

}
