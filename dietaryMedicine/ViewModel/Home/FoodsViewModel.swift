//
//  FoodsViewModel.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/25.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON

class FoodsViewModel: ViewModelProtocol {
    struct Output {
        let data = PublishRelay<Result<FoodList, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters
        
        provider.request(.foodAll) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                if let data = try? FoodList(JSON(rawValue: response.mapJSON())!) {
                    self.output.data.accept(.success(data))
                }
                else {
                    self.output.data.accept(.failure(.jsonParsingError))
                }
            case .failure:
                self.output.data.accept(.failure(.networkError))
            }
            
        }
    }
}
