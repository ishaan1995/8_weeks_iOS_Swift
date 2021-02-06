//
//  ViewController.swift
//  HelloWorld
//
//  Created by Ishaan Kakkar on 06/02/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func refreshBtnClicked(_ sender: UIButton) {
        sender.setTitle("Coming Soon", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

