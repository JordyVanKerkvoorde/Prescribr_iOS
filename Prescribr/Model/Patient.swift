//
//  Patient.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 11/12/2020.
//

import Foundation
import Mapper

struct Patient: Mappable, Encodable {
    var id: String
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var heightCM: Int
    var weightKG: Int
    var drugs: [String]?
    
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try firstName = map.from("firstName")
        try lastName = map.from("lastName")
        try dateOfBirth = map.from("dateOfBirth")
        try heightCM = map.from("heightCM")
        try weightKG = map.from("weightKG")
        try drugs = map.from("drugs")
    }
}
