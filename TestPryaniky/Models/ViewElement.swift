//
//  ViewElement.swift
//  TestPryaniky
//
//  Created by Vladislav on 04/04/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import Foundation

struct ViewElement: Decodable {
    var name: String
    var data: Any?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        switch self.name {
        case "hz":
            self.data = try container.decode(TextData.self, forKey: .data)
        case "picture":
            self.data = try container.decode(ImageData.self, forKey: .data)
        case "selector":
            self.data = try container.decode(VariantsData.self, forKey: .data)
        default:
            self.data = nil
            break
        }
    }
}
