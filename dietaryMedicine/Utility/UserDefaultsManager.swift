//
//  UserDefaultsManager.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/22.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: self.key) as? T ?? self.defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: self.key) }
    }
}

struct UserDefaultsManager {
    private static let TOKEN: String = "token"
    
    /// 사용자 토큰
    @UserDefault(key: TOKEN, defaultValue: "")
    static var token: String
}
