//
//  VariantsData.swift
//  TestPryaniky
//
//  Created by Vladislav on 03/04/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

struct Variants: Decodable {
    var selectedId: Int
    var variants: [Variant]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.selectedId = try container.decode(Int.self)
        self.variants = try container.decode([Variant].self)
    }
}
