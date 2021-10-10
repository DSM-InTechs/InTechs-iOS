//
//  RefreshRepository.swift
//  InTechs (iOS)
//
//  Created by GoEun Jeong on 2021/10/04.
//

import Foundation
import Moya

public protocol RefreshRepository {
    func refresh()
}

final public class RefreshRepositoryImpl: RefreshRepository {
    private let provider: MoyaProvider<InTechsAPI>
    
    @UserDefault(key: "accessToken", defaultValue: "")
    var accessToken: String
    
    @UserDefault(key: "refreshToken", defaultValue: "")
    var refreshToken: String
    
    public init(provider: MoyaProvider<InTechsAPI> = MoyaProvider<InTechsAPI>()) {
        self.provider = provider
    }
    
    public func refresh() {
        print(self.accessToken)
        print(self.refreshToken)
        
        provider.request(.refresh(refreshToken: self.refreshToken), completion: { result in
            switch result {
            case .success(let response):
                let data = try! JSONDecoder().decode(AuthReponse.self, from: response.data)
                self.accessToken = data.accessToken
                self.refreshToken = data.refreshToken
                
            case .failure(_):
                break
            }
        })
    }
}
