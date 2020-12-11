//
//  PatientService.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 11/12/2020.
//

import Foundation
import Alamofire
import Mapper

class PatientService {
    let baseURL = "https://prescribrapi.azurewebsites.net/api"
    
    let defaults = UserDefaults.standard
    
    let headers: HTTPHeaders
    
    init() {
        headers = [
        "Authorization": "Bearer \(defaults.string(forKey: "TOKEN")!)"
    ]
    }
    
    typealias PatientsServiceResponse = ([Patient]?, Error?) -> Void
    
    func getPatients(completion: @escaping PatientsServiceResponse){
        print("ONEEEE")
        AF.request(baseURL + "/patient/allpatients",
                   method: .get,
                   parameters: nil,
                   headers: headers)
            .validate()
            .responseJSON{ (response) in
                
                switch response.result {
                    case .success:
                        //print("SUCCESRESPONSE")
                        //print(response.value!)
                        var patients:[Patient] = []
                        for patient in response.value as! [Dictionary<String, AnyObject>] {
                            patients.append(Patient.from(patient as NSDictionary)!)
                        }
                        //print(patients)
                        completion(patients, nil)
                    case let .failure(error):
                        //print("FAILRESPONSE")
                        debugPrint(error)
                        completion(nil, error)
                }
            }
    }
}


