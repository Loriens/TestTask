//
//  ViewController.swift
//  TestPryaniky
//
//  Created by Vladislav on 03/04/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, MainViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(ServerRequestService().getData())
    }

}

