//
//  NutrientAnalysis.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/27.
//

import SwiftyJSON


//개별 영양 분석
class EachNutrientAnalysis {
    var deficiency = [DeficiencyNutrient]()
    var excess = [DeficiencyNutrient]()
    
    init(_ json: JSON) {
        if let array = json["deficiency"].array {
            deficiency = array.map { DeficiencyNutrient($0) }
        }
        if let array = json["excess"].array {
            excess = array.map { DeficiencyNutrient($0) }
        }
    }
}

class DeficiencyNutrient {
    var nutrientName = ""
    var nutrientImg = ""
    
    convenience init() {
        self.init(JSON())
    }
    
    init(_ json: JSON) {
        self.nutrientName = json["nutrient_name"].stringValue
        self.nutrientImg = json["circle_image"].stringValue
    }
}

//전체 영양 분석
class AllNutrientAnalysis {
    var list = [AnalysisList]()
    
    init(_ json: JSON) {
        if let array = json.array {
            list = array.map { AnalysisList($0) }
        }
    }
}

class AnalysisList {
    var nutrientNameKor = ""
    var nutrientImage = ""
    var averageAmount = 0
    var recommendAmount = 0
    var enoughAmount = 0
    var maximumAmount = 0
    var amount = 0
    
    init(_ json: JSON) {
        self.nutrientNameKor = json["nutrient"]["nutrient_name_kor"].stringValue
        self.nutrientImage = json["nutrient"]["nutrient_image"].stringValue
        self.averageAmount = json["average_amount"].intValue
        self.recommendAmount = json["recommend_amount"].intValue
        self.enoughAmount = json["enough_amount"].intValue
        self.maximumAmount = json["maximum_amount"].intValue
        self.amount = json["amount"].intValue
    }
}
