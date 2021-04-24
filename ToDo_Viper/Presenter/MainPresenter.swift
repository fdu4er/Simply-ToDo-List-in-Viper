//
//  MainPresenter.swift
//  ToDo_Viper
//
//  Created by Nik on 4/24/21.
//

import UIKit

protocol MainPresenterInput {
    func initialize(with vc: MainViewController)
    func registerCell()
    func setupDelegate()
    func addAction()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func numberOfRows() -> Int
    func cellForRowAt(_ indexPath: IndexPath) -> UITableViewCell
    func didSelectRowAt(_ indexPath: IndexPath)
    func leadingSwipeActionsConfigAt(_ indexPath: IndexPath) -> UISwipeActionsConfiguration
    func trailingSwipeActionsConfigAt(_ indexPath: IndexPath) -> UISwipeActionsConfiguration
}

class MainPresenter: MainPresenterInput{
    private init(){}
    private weak var vc: MainViewController!
    private var interactor = Interactor.shared
    private var router = MainRouter.create()
    static func create() -> MainPresenterInput{
        return MainPresenter()
    }
    
    func initialize(with vc: MainViewController) {
        self.vc = vc
    }
    
    func registerCell() {
        vc.tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        vc.tableView.rowHeight = 84
    }
    
    func setupDelegate(){
        vc.tableView.delegate = vc
        vc.tableView.dataSource = vc
    }
    
    func addAction(){
        let ac = UIAlertController(title: "Enter task name", message: nil, preferredStyle: .alert)
        ac.addTextField { (tf) in
            tf.placeholder = "Enter here"
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { [unowned self] (_) in
            interactor.addTask(withName: ac.textFields![0].text!)
            reloadData()
        }))
        vc.present(ac, animated: true, completion: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        router.prepare(for: segue, sender: sender)
    }
    
    func numberOfRows() -> Int{
        return interactor.returnTasks().count
    }
    
    func cellForRowAt(_ indexPath: IndexPath) -> UITableViewCell {
        return MainTableViewCell.createAndSetup(with: interactor.returnTasks()[indexPath.row], in: vc.tableView)
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        vc.tableView.deselectRow(at: indexPath, animated: true)
        vc.performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    func leadingSwipeActionsConfigAt(_ indexPath: IndexPath) -> UISwipeActionsConfiguration {
        return UISwipeActionsConfiguration(actions: [renameAction(at: indexPath)])
    }
    
    func trailingSwipeActionsConfigAt(_ indexPath: IndexPath) -> UISwipeActionsConfiguration {
        return UISwipeActionsConfiguration(actions: [deleteAction(at: indexPath)])
    }
    func reloadData() {
        vc.tableView.reloadData()
    }
    private func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (action, view, completion) in
            interactor.delete(interactor.returnTasks()[indexPath.row])
            vc.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
        action.backgroundColor = .systemRed
        return action
    }
    
    private func renameAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Rename") { [unowned self] (action, view, completion) in
            let ac = UIAlertController(title: "Enter new task name", message: nil, preferredStyle: .alert)
            ac.addTextField { (tf) in
                tf.placeholder = "Enter name here"
            }
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            ac.addAction(UIAlertAction(title: "Rename", style: .default, handler: { (_) in
                interactor.rename(interactor.returnTasks()[indexPath.row], to: ac.textFields![0].text!)
                reloadData()
            }))
            vc.present(ac, animated: true, completion: nil)
            completion(true)
        }
        action.backgroundColor = .systemOrange
        return action
    }
}
