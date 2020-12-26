//
//  PatientDrugCell.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 26/12/2020.
//

import UIKit

class PatientDrugCell: UITableViewCell {

    @IBOutlet var drugname: UILabel!
    
    func setDrugname(name: String) {
        drugname.text = name
    }
}
