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
    
    var drugs: [Drug] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableViewSetup()
        
        setLabelData()
        //if(patient?.drugs != nil){
            DrugService().getDrugList(idList: (patient?.drugs)!){ (success, fail) in
                if success != nil {
                    self.drugs = success ?? []
                }
                if fail != nil {
                    print("Request failed")
                }
                self.tableView.reloadData()
            }
        //}
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
        return drugs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientDrugCell", for: indexPath) as! PatientDrugCell
        
        cell.setDrugname(name: drugs[indexPath.item].name)
        
        
        
        return cell
    }

}
