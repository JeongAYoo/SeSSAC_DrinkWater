//
//  ProfileViewController.swift
//  SeSSAC_DrinkWater
//
//  Created by Jade Yoo on 2021/10/09.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var saveBarBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 41, green: 150, blue: 110, alpha: 1)
        saveBarBtn.title = "저장"
    }
    

}
