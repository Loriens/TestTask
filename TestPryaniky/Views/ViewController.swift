//
//  ViewController.swift
//  TestPryaniky
//
//  Created by Vladislav on 03/04/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var presenter: MainPresenter!
    private var itemNames: [String] = [String]()
    private var choosenSelector: VariantsData?
    
    private let reuseIdentifier = "MainCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = MainPresenter(serverService: ServerRequestService())
        self.presenter.setViewDelegate(mainViewDelegate: self)
        self.itemNames = presenter.getItemNames()
        
        self.tableView.frame = self.view.frame
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemNames.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter.didSelectCell(with: itemNames[indexPath.item])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
        
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
        case TypesData.selector.rawValue:
            let selectorData = presenter.getItemData(with: TypesData.selector.rawValue) as! VariantsData
            cell.textLabel?.text = selectorData.variants[selectorData.selectedId].text
        default:
            break
        }
        
        return cell
    }

}

// MARK: - MainViewDelegate
extension ViewController: MainViewDelegate {
    func createAlert(title: String) {
        createAlert(title: title, text: "")
    }
    
    func createAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func selectVariants() {
        self.choosenSelector = presenter.getItemData(with: "selector") as? VariantsData
        self.pickerView.frame = self.view.frame
        self.pickerView.isHidden = false
        self.tableView.isHidden = true
    }
    
    func hideVariants() {
        self.pickerView.isHidden = true
        self.tableView.reloadData()
        self.tableView.isHidden = false
    }
}

// MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.presenter.didSelectVariant(elem: row)
    }
}

// MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let number = choosenSelector?.variants.count else {
            return 0
        }
        
        return number
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let variants = choosenSelector?.variants else {
            return ""
        }
        
        return variants[row].text
    }
}

