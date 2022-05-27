//
//  SignUpViewModel.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/27.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON

class SignUpViewModel: ViewModelProtocol {
    struct Output {
        let data = PublishRelay<Result<Int, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters
        
        provider.request(.signUp) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.output.data.accept(.success(2000))
            case .failure:
                self.output.data.accept(.failure(.networkError))
            }
            
        }
        
    }
}
