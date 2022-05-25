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
    
    case signUp, logIn, logOut
    case unionList
    case supplementAll, supplementAdd
    case foodAll, foodAdd
    
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
        case .supplementAll, .foodAll, .unionList:
            return .get
        default:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .supplementAll, .foodAll, .unionList:
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
        case .signUp, .logIn:
            return header
        default:
//            header["Authorization"] = "Bearer \(UserDefaultsManager.token)"
            header["Authorization"] = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIzIiwiaXNzIjoiamsiLCJpYXQiOjE2NTMzODU2MDcsImV4cCI6MTY1NTk3NzYwN30.sFqontGRRSl4RTKbmjKcnYCqP4y_Pku9NXje4dYec1lsGUbPi3sxUCVH4HHbVASDBM-l5KH_LBlIb-gM60Sd5w"
            return header
        }
    }
    
    public var path: String {
        switch self {
        case .signUp: return "auth/signup" //가입
        case .logIn: return "auth/signin" //로그인
        case .unionList: return "combination/list" // 조합 리스트
        case .supplementAll: return "supplement/all" //영양제 리스트
        case .supplementAdd: return "combination-item/supplement" //조합 - 영양제 추가
        case .foodAll: return "food/all" //음식 리스트
        case .foodAdd: return "combination-item/food" //조합 - 음식 추가
        default:
            return ""
        }
    }
}
