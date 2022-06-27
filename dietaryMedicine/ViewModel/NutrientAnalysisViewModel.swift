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

class NutrientAnalysisViewModel: ViewModelProtocol {
    struct Output {
        let data = PublishRelay<Result<NutrientAnalysis, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters
        
        provider.request(.nutrientAnalysis) { result in
            switch result {
            case .success(let response):
                if let data = try? NutrientAnalysis(JSON(rawValue: response.mapJSON())!) {
                    self.output.data.accept(.success(data))
                }
            case .failure:
                self.output.data.accept(.failure(.networkError))
            }
    
        }
    }
}
