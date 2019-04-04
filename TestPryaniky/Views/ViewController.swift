//
//  ViewController.swift
//  TestPryaniky
//
//  Created by Vladislav on 03/04/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UITableViewController, MainViewDelegate {
    
    private var presenter: MainPresenter!
    private var itemNames: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = MainPresenter(serverService: ServerRequestService())
        self.itemNames = presenter.getItemNames()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell")!
        
        switch itemNames[indexPath.item] {
        case TypesData.hz.rawValue:
            let textData = presenter.getItemData(with: TypesData.hz.rawValue) as! TextData
            cell.textLabel?.text = textData.text
        case TypesData.picture.rawValue:
            let imageData = presenter.getItemData(with: TypesData.picture.rawValue) as! ImageData
            cell.textLabel?.text = imageData.text
            cell.imageView?.kf.setImage(with: URL(string: imageData.url), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, URL) in
                cell.setNeedsLayout()
            })
        default:
            break
        }
        
        return cell
    }

}

