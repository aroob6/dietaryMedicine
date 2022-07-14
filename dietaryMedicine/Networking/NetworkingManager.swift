//
//  NetworkingManager.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/23.
//

import Moya
import Alamofire
import SwiftUI

///네트워크 에러 케이스
enum NetworkError: Error {
    /// JSON Parsing 에러
    case jsonParsingError
    /// 네트워크 통신 에러
    case networkError
}

public enum NetworkingManager {
    public static var parameter = Parameters()
    
    case signUp, logIn, logOut, emailCheck, nameCheck //회원가입
    case combinationSupplementList, combinationFoodList //조합
    case supplementAll, supplementAdd, supplementDelete //영양제
    case foodAll, foodAdd, foodDelete //음식
    case nutrientAnalysis //영양분석
    case nutrientDiaryAdd, nutrientDiaryList //영양일지
    
}

extension NetworkingManager: TargetType {
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: ApiUrl.BASE_URL)!
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .supplementAll, .foodAll, .combinationSupplementList, .combinationFoodList, .nutrientDiaryList, .nutrientAnalysis:
            return .get
        case .supplementDelete, .foodDelete:
            return .delete
        default:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .supplementAll, .foodAll, .combinationSupplementList, .combinationFoodList, .nutrientDiaryList, .nutrientAnalysis:
            return .requestPlain //.get
        default:
            return .requestParameters(
                parameters: NetworkingManager.parameter,
                encoding: JSONEncoding.default) //.post body
        }
    }
    
    public var headers: [String : String]? {
        var header = ["Content-Type": "application/json"]
        switch self {
        case .signUp, .logIn, .emailCheck, .nameCheck:
            return header
        default:
            header["Authorization"] = "Bearer \(UserDefaultsManager.token)"
//            header["Authorization"] = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIzIiwiaXNzIjoiamsiLCJpYXQiOjE2NTMzODU2MDcsImV4cCI6MTY1NTk3NzYwN30.sFqontGRRSl4RTKbmjKcnYCqP4y_Pku9NXje4dYec1lsGUbPi3sxUCVH4HHbVASDBM-l5KH_LBlIb-gM60Sd5w"
            return header
        }
    }
    
    public var path: String {
        switch self {
        case .signUp: return "auth/signup" //가입
        case .logIn: return "auth/signin" //로그인
        case .emailCheck: return "auth/email-duplication"
        case .nameCheck: return "auth/name-duplication"
        case .combinationSupplementList: return "combination/list/supplement" // 조합 리스트 - 영양제
        case .combinationFoodList: return "combination/list/food" // 조합 리스트 - 음식
        case .supplementAll: return "supplement/all" //영양제 리스트
        case .supplementAdd: return "combination-item/supplement" //조합 - 영양제 추가
        case .supplementDelete: return "combination-item/supplement" //조합 - 영양제 삭제
        case .foodAll: return "food/all" //음식 리스트
        case .foodAdd: return "combination-item/food" //조합 - 음식 추가
        case .foodDelete: return "combination-item/food" //조합 - 음식 삭제
        case .nutrientAnalysis: return "combination/main/analysis" // 영양분석
        case .nutrientDiaryAdd: return "nutrient-diary" //영양일지(컬렉션) 추가
        case .nutrientDiaryList: return "nutrient-diary/list" //영양일지(컬렉션) 리스트
        default:
            return ""
        }
    }
}
