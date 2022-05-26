//
//  ViewModelProtocol.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/21.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON


protocol ViewModelProtocol: AnyObject {
    associatedtype Output
    var output: Output { get }
    
    func fetch(parameters: Parameters)
}
