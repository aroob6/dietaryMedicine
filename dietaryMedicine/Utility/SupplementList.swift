//
//  SupplementList.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/22.
//

import SwiftyJSON

class SupplementList {
    var error = ""
    var pageCount = 0
    var data = [Supplements]()
    
    convenience init() {
        self.init(JSON())
    }
    
    init(_ json: JSON) {
        error = json["error"].stringValue
        pageCount = json["page_count"].intValue
        if let array = json["data"].array {
            data = array.map { Supplements($0) }
        }
    }
}

class Supplements {
    var supplementID = 0
    var brand = ""
    var name = ""
    var content = ""
    var price = 0
    var link = ""
    var image = ""
    var daily = 0.0
    var unit = ""
    var nutrientAmounts = [NutrientAmount]()
    
    convenience init() {
        self.init(JSON())
    }
    
    init(_ json: JSON) {
        supplementID = json["supplement_id"].intValue
        brand = json["brand"].stringValue
        name = json["name"].stringValue
        content = json["content"].stringValue
        price = json["price"].intValue
        link = json["link"].stringValue
        image = json["image"].stringValue
        daily = json["daily"].doubleValue
        unit = json["unit"].stringValue
        
        if let array = json["nutrient_amounts"].array {
            nutrientAmounts = array.map { NutrientAmount($0) }
        }
    }
}

class NutrientAmount {
    var nutrientNameEng = ""
    var nutrientNameKor = ""
    var nutrientAmount = 0.0
    var nutrientAmountUnit = ""
    init(_ json: JSON) {
        nutrientNameEng = json["nutrient_name_eng"].stringValue
        nutrientNameKor = json["nutrient_name_kor"].stringValue
        nutrientAmount = json["nutrient_amount"].doubleValue
        nutrientAmountUnit = json["unit"].stringValue
    }
}
