//
//  Interactor.swift
//  ToDo_Viper
//
//  Created by Nik on 4/24/21.
//

import Foundation
import CoreData

protocol InteractorInput {
    func returnTasks() -> [Task]
    func addTask(withName name: String)
    func delete(_ task: Task)
    func rename(_ task: Task, to newName: String)
    func formatDate(_ date: Date) -> String
}

class Interactor: InteractorInput {
    private var dbManager: DataBaseManager = .shared
    private init(){}
    
    static let shared: InteractorInput = Interactor()
    
    func returnTasks() -> [Task] {
        let request = NSFetchRequest<Task>(entityName: "Task")
        let sd = NSSortDescriptor(key: "dateCreated", ascending: false)
        request.sortDescriptors = [sd]
        guard let result = try? dbManager.context.fetch(request) else { return [] }
        return result
    }
    
    func addTask(withName name: String) {
        let task = Task(context: dbManager.context)
        task.dateCreated = Date()
        task.name = name
        dbManager.saveContext()
    }
    
    func rename(_ task: Task, to newName: String) {
        task.name = newName
        dbManager.saveContext()
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
    
    func delete(_ task: Task){
        dbManager.context.delete(task)
        dbManager.saveContext()
    }
}
