//
//  MainRouter.swift
//  ToDo_Viper
//
//  Created by Nik on 4/24/21.
//

import UIKit

protocol MainRouterInput {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class MainRouter: MainRouterInput {
    static func create() -> MainRouterInput{
        return MainRouter()
    }
    private init(){}
    
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let vc = segue.destination as? DetailViewController, segue.identifier == "toDetail"{
            let task = Interactor.shared.returnTasks()[(sender as! IndexPath).row]
            vc.name = task.name!
            vc.dateString = Interactor.shared.formatDate(task.dateCreated!)
        }
    }
}
