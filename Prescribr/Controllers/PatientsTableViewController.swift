//
//  PatientsTableViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 11/12/2020.
//

import UIKit

class PatientsTableViewController: UITableViewController {
    
    public var patients: [Patient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PatientService().getPatients(){ (response, fail) in
            if response != nil {
                self.patients = response!
            }
            if fail != nil {
                print("REQUEST FAILED")
            }
        
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ShowPatientsDetails")
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientCell", for: indexPath) as! PatientCell
        let patient = patients[indexPath.item]
        cell.setName(firstName: patient.firstName, lastName: patient.lastName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowPatientsDetails", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPatientsDetails" {
            let detailViewController = segue.destination as! PatientsDetailViewController
            
            let index = (self.tableView.indexPathForSelectedRow?.item)!
            let patient = patients[index]
            
            detailViewController.patient = patient
        }
    }

}
