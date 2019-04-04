//
//  ViewData.swift
//  TestPryaniky
//
//  Created by Vladislav on 04/04/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import Foundation

struct ViewData: Decodable {
    var data: Array<ViewElement>
    var view: Array<String>
}
