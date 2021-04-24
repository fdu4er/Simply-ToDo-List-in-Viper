//
//  DetailViewController.swift
//  ToDo_Viper
//
//  Created by Nik on 4/24/21.
//

import UIKit

class DetailViewController: UIViewController {

    var name = ""
    var dateString = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        dateLabel.text = dateString
        // Do any additional setup after loading the view.
    }

}
