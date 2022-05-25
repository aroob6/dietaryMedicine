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
    var itemType = ItemType.supplement
    
    struct Output {
        let data = PublishRelay<Result<Int, NetworkError>>()
    }
    
    @Injected private var provider: MoyaProvider<NetworkingManager>
    
    public let output = Output()
    
    func fetch(parameters: Parameters) {
        NetworkingManager.parameter = parameters
        
        var type = NetworkingManager.supplementAdd
        switch itemType {
        case .supplement:
            type = NetworkingManager.supplementAdd
        case .food:
            type = NetworkingManager.foodAdd
        }
        
        provider.request(type) { result in
            switch result {
            case .success:
                self.output.data.accept(.success(2000))
            case .failure:
                self.output.data.accept(.failure(.networkError))
            }
    
        }
    }
}
