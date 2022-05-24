//
//  ItemDetailViewModel.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/24.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON

class ItemDetailViewModel: ViewModelProtocol {
    struct Output {
        let data = PublishRelay<Result<SupplementList, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters
        
        provider.request(.supplementAdd) { result in
    
            switch result {
            case .success:
                print("post success")
            case .failure:
                print("post error")
            }
    
        }
    }
}
