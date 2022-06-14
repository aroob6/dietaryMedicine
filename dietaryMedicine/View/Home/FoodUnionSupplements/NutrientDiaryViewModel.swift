//
//  NutrientDiaryViewModel.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/06/14.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON

class NutrientDiaryViewModel: ViewModelProtocol {
    struct Output {
        let data = PublishRelay<Result<MyNutrientDiary, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters
        
        provider.request(.nutrientDiaryList) { result in
            switch result {
            case .success(let response):
                if let data = try? MyNutrientDiary(JSON(rawValue: response.mapJSON())!) {
                    self.output.data.accept(.success(data))
                }
            case .failure:
                self.output.data.accept(.failure(.networkError))
            }
    
        }
    }
}
