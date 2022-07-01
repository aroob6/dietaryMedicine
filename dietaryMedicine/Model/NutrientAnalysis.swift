//
//  NutrientAnalysis.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/27.
//

import SwiftyJSON

class NutrientAnalysis {
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
