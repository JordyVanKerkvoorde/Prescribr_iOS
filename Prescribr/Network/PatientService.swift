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
    typealias RiskServiceResponse = (NSDictionary?, Error?) -> Void
    
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
        print("ADD")
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
            .cURLDescription{ description in
                print(description)
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
    
    func assessRisk(patientId: String, completion: @escaping RiskServiceResponse){
        let dto = RiskDTO(patientID: patientId)
        AF.request(baseURL + "/patient/assessrisk",
                   method: .post,
                   parameters: dto,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .validate()
            .responseJSON{ response in
                switch response.result{
                    case .success:
                        //print(response.value!)
                        completion(response.value as? NSDictionary, nil)
                    case let .failure(error):
                        debugPrint(error)
                        completion(nil, error)
                }
            }
    }
}

struct RiskDTO: Encodable {
    let patientID: String
}


