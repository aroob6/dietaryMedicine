//
//  FoodList.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/25.
//

import SwiftyJSON

class FoodList {
    var error = ""
    var pageCount = 0
    var data = [Foods]()
    
    convenience init() {
        self.init(JSON())
    }
    
    init(_ json: JSON) {
        error = json["error"].stringValue
        pageCount = json["page_count"].intValue
        if let array = json["data"].array {
            data = array.map { Foods($0) }
        }
    }
}

class Foods {
    var foodID = 0
    var brand = ""
    var name = ""
    var content = ""
    var price = 0
    var link = ""
    var image = ""
    var amount = 0
    var nutrientAmounts = [NutrientAmount]()
    
    
    convenience init() {
        self.init(JSON())
    }
    
    init(_ json: JSON) {
        foodID = json["food_id"].intValue
        brand = json["brand"].stringValue
        name = json["name"].stringValue
        content = json["content"].stringValue
        price = json["price"].intValue
        link = json["link"].stringValue
        image = json["image"].stringValue
        amount = json["amount"].intValue
        
        if let array = json["nutrient_amounts"].array {
            nutrientAmounts = array.map { NutrientAmount($0) }
        }
    }
}
