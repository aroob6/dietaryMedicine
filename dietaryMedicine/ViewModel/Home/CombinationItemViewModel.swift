//
//  FoodUnionSupplementsViewModel.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/24.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON

class CombinationSupplementsViewModel: ViewModelProtocol {
    struct Output {
        let data = PublishRelay<Result<CombinationItemList, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        provider.request(.combinationSupplementList) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                if let data = try? CombinationItemList(JSON(rawValue: response.mapJSON())!) {
                    self.output.data.accept(.success(data))
                }
            case .failure:
                self.output.data.accept(.failure(.networkError))
            }
            
        }
    }
}

class CombinationFoodsViewModel: ViewModelProtocol {
    struct Output {
        let data = PublishRelay<Result<CombinationItemList, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        provider.request(.combinationFoodList) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                if let data = try? CombinationItemList(JSON(rawValue: response.mapJSON())!) {
                    self.output.data.accept(.success(data))
                }
            case .failure:
                self.output.data.accept(.failure(.networkError))
            }
            
        }
    }
}
