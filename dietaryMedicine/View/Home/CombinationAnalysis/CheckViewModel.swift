//
//  CheckViewModel.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/06/08.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON

class CheckViewModel: ViewModelProtocol {
    var checkType = CheckType.email
    
    struct Output {
        let data = PublishRelay<Result<Int, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters
        
        var path = NetworkingManager.emailCheck
        switch checkType {
        case .email: path = NetworkingManager.emailCheck
        case .name: path = NetworkingManager.nameCheck
        }
        
        provider.request(path) { result in
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
