//
//  NutrientDiaryAddViewModel.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/14.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON

class NutrientDiaryAddViewModel: ViewModelProtocol {
    struct Output {
        let data = PublishRelay<Result<Int, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters
        
        provider.request(.nutrientDiaryAdd) { result in
            switch result {
            case .success:
                self.output.data.accept(.success(2000))

            case .failure:
                self.output.data.accept(.failure(.networkError))
            }
    
        }
    }
}
