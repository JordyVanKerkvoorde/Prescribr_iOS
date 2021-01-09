//
//  PatientsDetailViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 11/12/2020.
//

import UIKit
import PaddingLabel

class PatientsDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var patient: Patient?
    
    @IBOutlet var firstname: UILabel!
    @IBOutlet var lastname: UILabel!
    @IBOutlet var dateOfBirth: UILabel!
    @IBOutlet var height: UILabel!
    @IBOutlet var weight: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var drugsTitle: PaddingLabel!
    
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
                if(self.drugs.isEmpty){
                    self.tableView.isHidden = true
                    self.drugsTitle.isHidden = true
                }
            }
        //}
    }
    
    fileprivate func tableViewSetup() {
        if(patient!.drugs!.isEmpty){
            tableView.isHidden = true
        }
    }
    
    fileprivate func setLabelData() {
        firstname.text = "FIRSTNAME: " + patient!.firstName
        lastname.text = "LASTNAME: " + patient!.lastName
        dateOfBirth.text = "DATE OF BIRTH: " + convertDate(datestring: patient!.dateOfBirth)
        height.text = "HEIGHT: " + String(patient!.heightCM)
        weight.text = "WEIGHT: " + String(patient!.weightKG)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(drugs)
        //print(drugs.count)
        return drugs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientDrugCell", for: indexPath) as! PatientDrugCell
        //print(drugs[indexPath.item].name)
        cell.setDrugname(name: drugs[indexPath.item].name)
        
        
        
        return cell
    }
    
    func convertDate(datestring: String) -> String{
        let date = datestring.split(separator: "T")
        let dateArr = date[0].split(separator: "-")
        let year = dateArr[0]
        let month = dateArr[1]
        let day = dateArr[2]
        
        return "\(day)/\(month)/\(year)"
    }
}
