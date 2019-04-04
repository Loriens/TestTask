//
//  MainPresenter.swift
//  TestPryaniky
//
//  Created by Vladislav on 04/04/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import Foundation

protocol MainViewDelegate: NSObjectProtocol {
    
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
    
}
