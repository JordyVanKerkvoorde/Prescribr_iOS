//
//  PatientsDetailViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 11/12/2020.
//

import UIKit

class PatientsDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var patient: Patient?

    @IBOutlet var firstname: UILabel!
    @IBOutlet var lastname: UILabel!
    @IBOutlet var dateOfBirth: UILabel!
    @IBOutlet var height: UILabel!
    @IBOutlet var weight: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableViewSetup()
        
        setLabelData()
    }
    fileprivate func tableViewSetup() {
        if(patient!.drugs!.isEmpty){
            tableView.isHidden = true
        }
    }
    
    fileprivate func setLabelData() {
        firstname.text = patient!.firstName
        lastname.text = patient!.lastName
        dateOfBirth.text = patient!.dateOfBirth
        height.text = String(patient!.heightCM)
        weight.text = String(patient!.weightKG)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patient!.drugs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientDrugCell", for: indexPath) as! PatientDrugCell
        let drugs = patient?.drugs
        cell.setDrugname(name: drugs?[indexPath.item] ?? "")
        
        
        
        return cell
    }

}
