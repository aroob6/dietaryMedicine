//
//  NutrientAnalysisViewModel.swift
//  dietaryMedicine
//
//  Created by bora on 2022/06/27.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON

class EachNutrientAnalysisViewModel: ViewModelProtocol {
    struct Output {
        let data = PublishRelay<Result<EachNutrientAnalysis, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters
        
        provider.request(.eachNutrientAnalysis) { result in
            switch result {
            case .success(let response):
                if let data = try? EachNutrientAnalysis(JSON(rawValue: response.mapJSON())!) {
                    self.output.data.accept(.success(data))
                }
            case .failure:
                self.output.data.accept(.failure(.networkError))
            }
    
        }
    }
}
