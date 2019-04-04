//
//  MainPresenter.swift
//  TestPryaniky
//
//  Created by Vladislav on 04/04/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import Foundation

protocol MainViewDelegate: NSObjectProtocol {
    func createAlert(title: String)
    func createAlert(title: String, text: String)
    func selectVariants()
    func hideVariants()
}

class MainPresenter {
    
    private let serverService: ServerRequestService
    private var viewData: ViewData?
    private var allItemData: [String: Any] = [String: Any]()
    weak private var mainViewDelegate: MainViewDelegate?
    
    init(serverService: ServerRequestService) {
        self.serverService = serverService
        
        guard let data = serverService.getData() else {
            return
        }
        self.viewData = data
        self.allItemData = [String: Any]()
        
        viewData!.data.forEach({ elem in
            self.allItemData[elem.name] = elem.data
        })
    }
    
    func setViewDelegate(mainViewDelegate: MainViewDelegate) {
        self.mainViewDelegate = mainViewDelegate
    }
    
    func getItemNames() -> [String] {
        guard let data = viewData else {
            return []
        }
        
        return data.view
    }
    
    func getItemData(with name: String) -> Any? {
        return allItemData[name]
    }
    
    func didSelectVariant(elem: Int) {
        var selector = allItemData[TypesData.selector.rawValue] as! VariantsData
        selector.selectedId = elem
        mainViewDelegate?.hideVariants()
        mainViewDelegate?.createAlert(title: TypesData.selector.rawValue, text: "You selected \(selector.variants[elem].text)")
    }
    
    func didSelectCell(with name: String, elem: Int = 0) {
        if name == TypesData.selector.rawValue {
            mainViewDelegate?.selectVariants()
        } else {
            mainViewDelegate?.createAlert(title: name)
        }
    }
    
}
