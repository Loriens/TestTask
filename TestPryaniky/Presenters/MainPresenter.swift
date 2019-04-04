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
    weak private var mainViewDelegate: MainViewDelegate?
    
    init(serverService: ServerRequestService) {
        self.serverService = serverService
        self.viewData = serverService.getData()
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
    
}
