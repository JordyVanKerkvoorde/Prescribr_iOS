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
    typealias PatientServiceResponse = (Patient?, Error?) -> Void
    
    func getPatients(completion: @escaping PatientsServiceResponse){
        AF.request(baseURL + "/patient/allpatients",
                   method: .get,
                   parameters: nil,
                   headers: headers)
            .validate()
            .responseJSON{ (response) in
                
                switch response.result {
                    case .success:
                        var patients:[Patient] = []
                        for patient in response.value as! [Dictionary<String, AnyObject>] {
                            patients.append(Patient.from(patient as NSDictionary)!)
                        }
                        completion(patients, nil)
                    case let .failure(error):
                        debugPrint(error)
                        completion(nil, error)
                }
            }
    }
    
    func addPatient(patientDTO: PatientDTO, completion: @escaping PatientServiceResponse){
        AF.request(baseURL + "/patient/addpatient",
                   method: .post,
                   parameters: patientDTO,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .validate()
            .responseJSON{ response in
                switch response.result {
                    case .success:
                        let patient = Patient.from(response.value as! NSDictionary)
                        completion(patient, nil)
                    case let .failure(error):
                        debugPrint(error)
                        completion(nil, error)
                }
            }
    }
    
    func updatePatient(patient: Patient, completion: @escaping PatientServiceResponse){
        AF.request(baseURL + "/patient/updatepatient",
                   method: .post,
                   parameters: patient,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .validate()
            .responseJSON{ response in
                switch response.result{
                    case .success:
                        let patient = Patient.from(response.value as! NSDictionary)
                        completion(patient, nil)
                    case let .failure(error):
                        debugPrint(error)
                        completion(nil, error)
                }
            }
    }
}


