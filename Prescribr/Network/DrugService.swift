//
//  DrugService.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 27/12/2020.
//

import Foundation
import Alamofire
import Mapper

class DrugServive {
    let baseURL = "https://prescribrapi.azurewebsites.net/api"
    
    let defaults = UserDefaults.standard
    
    let headers: HTTPHeaders
    
    init() {
        headers = [
        "Authorization": "Bearer \(defaults.string(forKey: "TOKEN")!)"
    ]
    }
    
    typealias AllDrugServiceResponse = ([Drug]?, Error?) -> Void
    typealias DrugServiceResponse = (Drug?, Error?) -> Void
    
    func getAllDrugs(completion: @escaping AllDrugServiceResponse) {
        AF.request(baseURL + "/drugs/alldrugs",
                   method: .get,
                   parameters: nil,
                   headers: headers)
            .validate()
            .responseJSON{ (response) in
                switch response.result {
                    case .success:
                        print(response.value!)
                        completion(nil, nil)
                case let .failure(error):
                    debugPrint(error)
                    completion(nil, error)
                }
            }
    }
    
    func getDrug(id: String, completion: @escaping DrugServiceResponse) {
        
    }
}
