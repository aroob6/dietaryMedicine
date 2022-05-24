//
//  UnionItem.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/24.
//

import SwiftyJSON

struct UnionItemList {
    var list = [Item]()
    
    init() {
        
    }
    
    init(_ json: JSON) {
        if let array = json["combination_items"].array {
            list = array.map { Item($0) }
        }
    }
}

class Item {
    var type = ""
    var combinationItemId = 0
    var combinationId = 0
    var image = ""
    var foodId = 0
    var supplementId = 0
    
    init(_ json: JSON) {
        type = json["type"].stringValue
        combinationItemId = json["combination_item_id"].intValue
        combinationId = json["combination_id"].intValue
        image = json["image"].stringValue
        foodId = json["food_id"].intValue
        supplementId = json["supplement_id"].intValue
    }
}
