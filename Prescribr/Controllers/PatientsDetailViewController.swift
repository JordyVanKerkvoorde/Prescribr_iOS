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
    var risks: NSDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableViewSetup()
        
        setLabelData()
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
        print("test")
        assessRisk()
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
        return drugs.count
    }
    
    fileprivate func assessRisk() {
        PatientService().assessRisk(patientId: self.patient!.id){ (success, fail) in
            if success != nil {
                print(success!)
                self.risks = success!
            }
            if fail != nil {
                print("Request failed")
            }
            print("RISK DONE")
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientDrugCell", for: indexPath) as! PatientDrugCell
        //print(drugs[indexPath.item].name)
        cell.setDrugname(name: drugs[indexPath.item].name)
        
        if(risks.count != 0 && !drugs.isEmpty){
            print(risks)
            if(risks[drugs[indexPath.item].id] != nil){
                let isBad: Bool = risks[drugs[indexPath.item].id] as! Int == 1
                cell.setRiskStyle(isRisk: isBad)
            }
        }
        
                
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
    
    
    @IBAction func onPrescribe(_ sender: Any) {
        let vc = UIStoryboard(name: "Patients", bundle: nil).instantiateViewController(withIdentifier: "prescribe") as! PrescribeDrugTableViewController
        //let controller = PrescribeDrugTableViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func prescribeDrug(drug: Drug){
        print(drug)
        self.drugs.append(drug)
        self.patient?.drugs?.append(drug.id)
        //do network call
        PatientService().updatePatient(patient: patient!){ (success, fail) in
            if(success != nil){
                print(success!)
                //redo checks
                print("ASSESS")
                self.assessRisk()
                self.tableView.reloadData()
            }
            if(fail != nil){
                print(fail!)
            }
        }
    }
}

extension PatientsDetailViewController: PrescribeDrugTableViewControllerDelegate {
    func addDrug(_ drug: Drug) {
        self.prescribeDrug(drug: drug)
    }
}
