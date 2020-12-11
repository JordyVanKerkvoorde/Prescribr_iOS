//
//  File.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 11/12/2020.
//

struct Patient {
    var id: String
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var heightCM: Int
    var weightKG: Int
    var drugs: [Any] //change to struct type
}

