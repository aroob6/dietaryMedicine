//
//  Injection.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/22.
//

import Foundation
import Resolver
import RxSwift
import RxCocoa
import Moya

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        
        // Controller
        register { MainTabBarController() }
        register { MainViewController() }
        register { ItemDetailViewController() }
        
        //Cell
        register { FoodUnionSupplementsTableViewCell() }
        
        // Networking
        register { MoyaProvider<NetworkingManager>() }.scope(.application)
        
        // RxSwift
        register { DisposeBag() }.scope(.application)
        
        //viewModel
        register { LoginViewModel() }
        register { SupplementsViewModel() }
        register { ItemDetailViewModel() }
        register { FoodUnionSupplementsViewModel() }
    }
}
