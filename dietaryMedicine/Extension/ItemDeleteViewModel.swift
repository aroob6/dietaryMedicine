//
//  DeleteItemViewModel.swift
//  dietaryMedicine
//
//  Created by bora on 2022/05/26.
//

import RxCocoa
import Alamofire
import Moya
import Resolver
import SwiftyJSON

class ItemDeleteViewModel: ViewModelProtocol {
    var itemType = ItemType.supplement
    
    struct Output {
        let data = PublishRelay<Result<Int, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters
        
        var path = NetworkingManager.supplementDelete
        switch itemType {
        case .supplement:
            path = NetworkingManager.supplementDelete
        case .food:
            path = NetworkingManager.foodDelete
        }
        
        provider.request(path) { result in
            switch result {
            case .success:
                self.output.data.accept(.success(2000))
            case .failure:
                self.output.data.accept(.failure(.networkError))
            }
    
        }
    }
}
