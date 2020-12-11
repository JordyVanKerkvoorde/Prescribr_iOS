//
//  PatientService.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 11/12/2020.
//

import Foundation

class PatientService {
    func getPatients(){
        let defaults = UserDefaults.standard
        print(defaults.string(forKey: "USERMAIL")!)
    }
}
