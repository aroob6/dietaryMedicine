//
//  MyNutrientDiaryList.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/06/14.
//

import SwiftyJSON

class MyNutrientDiary {
    var list = [MyNutrientDiaryList]()
    
    init(_ json: JSON) {
        if let array = json.array {
            list = array.map { MyNutrientDiaryList($0) }
        }
    }
}

class MyNutrientDiaryList {
    var nutrientDiaryID = 0
    var title = ""
    var content = ""
    var nutrientDiaryItemList = [NutrientDiaryItemList]()
    
    init(_ json: JSON) {
        self.nutrientDiaryID = json["nutrient_diary_id"].intValue
        self.title = json["title"].stringValue
        self.content = json["content"].stringValue
        if let array = json["nutrient_diary_item_response_dtos"].array {
            nutrientDiaryItemList = array.map { NutrientDiaryItemList($0) }
        }
    }
}

class NutrientDiaryItemList {
    var nutrientDiaryItemID = 0
    var nutrientDiaryID = 0
    var type = ""
    var image = ""
    var supplementID = 0
    var foodID = 0
    
    init(_ json: JSON) {
        self.nutrientDiaryItemID = json["nutrient_diary_item_id"].intValue
        self.nutrientDiaryID = json["nutrient_diary_id"].intValue
        self.type = json["type"].stringValue
        self.image = json["image"].stringValue
        self.supplementID = json["supplement_id"].intValue
        self.foodID = json["food_id"].intValue
    }
}
