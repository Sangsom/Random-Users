//
//  UserDetailsViewController.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 27/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    var user: Person!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Opening", user.fullName)
        // Do any additional setup after loading the view.
    }
    
}
