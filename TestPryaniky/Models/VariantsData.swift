//
//  VariantsData.swift
//  TestPryaniky
//
//  Created by Vladislav on 03/04/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

struct VariantsData: Decodable {
    var selectedId: Int
    var variants: [VariantData]
    
    private enum CodingKeys: String, CodingKey {
        case selectedId
        case variants
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.selectedId = try container.decode(Int.self, forKey: .selectedId)
        self.variants = try container.decode([VariantData].self, forKey: .variants)
    }
}
