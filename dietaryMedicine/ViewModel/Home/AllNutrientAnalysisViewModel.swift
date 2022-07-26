//
//  AllNutrientAnalysisViewModel.swift
//  dietaryMedicine
//
//  Created by bora on 2022/07/26.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON

class AllNutrientAnalysisViewModel: ViewModelProtocol {
    struct Output {
        let data = PublishRelay<Result<AllNutrientAnalysis, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters
        
        provider.request(.allNutrientAnalysis) { result in
            switch result {
            case .success(let response):
                if let data = try? AllNutrientAnalysis(JSON(rawValue: response.mapJSON())!) {
                    self.output.data.accept(.success(data))
                }
            case .failure:
                self.output.data.accept(.failure(.networkError))
            }
    
        }
    }
}
