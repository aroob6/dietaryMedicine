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

class ItemDetailViewModel: GetViewModelProtocol {
    @Injected private var provider: MoyaProvider<NetworkingManager>
    
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
