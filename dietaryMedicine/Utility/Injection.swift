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
        
        //Cell
        register { FoodUnionSupplementsTableViewCell() }
        
        // Networking
        register { MoyaProvider<NetworkingManager>() }.scope(.application)
        
        // RxSwift
        register { DisposeBag() }.scope(.application)
        
        //viewModel
        register { SignUpViewModel() }
        register { LoginViewModel() }
        register { CombinationSupplementsViewModel() }
        register { CombinationFoodsViewModel() }
        register { SupplementsViewModel() }
        register { FoodsViewModel() }
        register { ItemAddViewModel() }
        register { ItemDeleteViewModel() }
        register { EmailCheckViewModel() }
        register { NutrientDiaryAddViewModel() }
        register { NutrientDiaryViewModel() }
    }
}
