//
//  Drug.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 11/12/2020.
//

import Foundation
import Mapper

struct Drug : Mappable{
    var id: String
    var name: String
    var description: String
    var negativeInteractions: [String]
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
        try description = map.from("description")
        try negativeInteractions = map.from("negativeInteractions")
    }
}
