//
//  Login.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/21.
//

import Foundation
import SwiftyJSON


//struct LoginPatameter: Codable {
//    var email: String
//    var password: String
//    
//    init(_ email: String, _ password: String) {
//        self.email = email
//        self.password = password
//    }
//}
//
//struct Login: Codable {
//    let token: String
//    let email: String
//    let name: String
//    let password: String
//    let profileImage: String
//    let birthDate: String
//    let gender: String
//    let userID: Int
//
//    enum CodingKeys: String, CodingKey {
//        case token, email, name, password, gender
//        case profileImage = "profile_image"
//        case birthDate = "birth_date"
//        case userID = "user_id"
//    }
//}


enum ResultString {
    case success
    case failure
}

class Login {
    var token = ""
    var email = ""
    var name = ""
    var password = ""
    var profile_image = ""
    var birth_date = ""
    var gender = ""
    var user_id = ""

    init(_ json: JSON) {
        token = json["token"].stringValue
        email = json["email"].stringValue
        name = json["name"].stringValue
        password = json["password"].stringValue
        profile_image = json["profile_image"].stringValue
        birth_date = json["birth_date"].stringValue
        gender = json["gender"].stringValue
        user_id = json["user_id"].stringValue
    }
}

//test값
//{
//  "token": "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIzIiwiaXNzIjoiamsiLCJpYXQiOjE2NTMwOTUwOTIsImV4cCI6MTY1MzE4MTQ5Mn0.OOYsLe0TLai9eQHVADVOeNBBCDRkdwgHxLREkL_AdBQF2yey2XkLvTvKfMkXlEvQJw-DtMYaTtOdmZkgYCfSTw",
//  "email": "test@naver.com",
//  "name": null,
//  "password": null,
//  "profile_image": null,
//  "birth_date": null,
//  "gender": null,
//  "user_id": 3
//}
