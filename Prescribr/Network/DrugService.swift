//
//  DrugService.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 27/12/2020.
//

import Foundation
import Alamofire
import Mapper

class DrugService {
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
        AF.request(baseURL + "/drug/alldrugs",
                   method: .get,
                   parameters: nil,
                   headers: headers)
            .validate()
            .responseJSON{ (response) in
                switch response.result {
                    case .success:
                        var drugs: [Drug] = []
                        for drug in response.value as! [Dictionary<String, AnyObject>] {
                            drugs.append(Drug.from(drug as NSDictionary)!)
                        }
                        //print(drugs)
                        completion(drugs, nil)
                case let .failure(error):
                    debugPrint(error)
                    completion(nil, error)
                }
            }
    }
    
    func getDrug(id: String, completion: @escaping DrugServiceResponse) {
        
    }
    
    func getDrugList(idList: [String], completion: @escaping AllDrugServiceResponse){
        
        let idList = IdList(idList: idList)
        
        AF.request(baseURL + "/drug/drugslist",
                   method: .post,
                   parameters: idList,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .validate()
            .responseJSON{ (response) in
                switch response.result {
                    case .success:
                        var drugs: [Drug] = []
                        for drug in response.value as! [Dictionary<String, AnyObject>] {
                            drugs.append(Drug.from(drug as NSDictionary)!)
                        }
                        completion(drugs, nil)
                    case let .failure(error):
                        debugPrint(error)
                        completion(nil, error)
                }
            }
    }
}

struct IdList: Encodable {
    let idList:[String]
}
