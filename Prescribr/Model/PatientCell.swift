//
//  PatientCell.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 12/12/2020.
//

import UIKit

class PatientCell: UITableViewCell {
    
    @IBOutlet var patientName: UILabel!
    
    func setName(firstName: String, lastName: String){
        patientName.text = "\(firstName) \(lastName)"
    }
}
