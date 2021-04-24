//
//  MainTableViewCell.swift
//  ToDo_Viper
//
//  Created by Nik on 4/24/21.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet private weak var bcgView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bcgView.layer.cornerRadius = 10
    }
    
    static func createAndSetup(with task: Task, in tableView: UITableView) -> MainTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! MainTableViewCell
        cell.nameLabel.text = task.name
        cell.dateLabel.text = Interactor.shared.formatDate(task.dateCreated!)
        return cell
    }
}
