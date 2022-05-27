//
//  ViewDelegate.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/25.
//

import Foundation

protocol ViewDelegate: AnyObject {
    func unionItemRefresh()
}

class StaticDelegate: ViewDelegate {
    static weak var mainDelegate: ViewDelegate?
    
    func unionItemRefresh() {
        StaticDelegate.mainDelegate?.unionItemRefresh()
    }
}
