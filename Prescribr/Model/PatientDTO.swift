//
//  PatientDTO.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 30/12/2020.
//

import Foundation

struct PatientDTO: Encodable{
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var heightCM: Int
    var weightKG: Int
}
