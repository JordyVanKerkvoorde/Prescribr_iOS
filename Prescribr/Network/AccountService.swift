//
//  AccountService.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 09/12/2020.
//

import Foundation
import Alamofire

class AccountService {
    
    let loginUrl = "https://prescribrapi.azurewebsites.net/api/login"
    let testUrl = "https://api.icndb.com/jokes/random"
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer {token}"
    ]
    
    typealias ServiceResponse = (Any?, Error?) -> Void
    
    func login(username: String, password: String, completion: @escaping ServiceResponse) {
        let login = Login(email: username, password: password)
        
        AF.request(loginUrl,
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default)
            .validate()
            .responseJSON{ (response) in
                
                switch response.result {
                    case .success:
                        //print(response.value!)
                        completion(response.value!, nil)
                    case let .failure(error):
                        completion(nil, error)
                }
            }
    }
    
    
}

struct Login: Encodable {
    let email: String
    let password: String
}
