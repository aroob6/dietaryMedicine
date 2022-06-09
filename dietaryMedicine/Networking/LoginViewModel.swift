//
//  LoginViewModel.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/21.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON

class LoginViewModel: ViewModelProtocol {
    
    struct Output {
        let data = PublishRelay<Result<Login, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters

        provider.request(.logIn) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                if let data = try? Login(JSON(rawValue: response.mapJSON())!) {
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
