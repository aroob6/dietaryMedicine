//
//  DuplicateConfirmViewModel.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/06/08.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON

class EmailCheckViewModel: ViewModelProtocol {
    struct Output {
        let data = PublishRelay<Result<Int, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters
        
        provider.request(.emailCheck) { result in
            switch result {
            case .success(let response):
                if let data = try? response.map(Int.self) {
                    self.output.data.accept(.success(data))
                }

            case .failure:
                self.output.data.accept(.failure(.networkError))
            }
    
        }
    }
}
