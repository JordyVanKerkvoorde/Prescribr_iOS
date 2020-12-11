//
//  PatientsTableViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 11/12/2020.
//

import UIKit

class PatientsTableViewController: UITableViewController {
    
//    public var models: [String] = [
//        "Test",
//        "One",
//        "Two",
//        "Three"
//    ]
    
    
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
        
            print(self.patients)
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(patients.count)
        return patients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let patient = patients[indexPath.item]
        print(patient)
        cell.textLabel?.text = "\(patient.firstName) \(patient.lastName)"
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
            
            detailViewController.myTitle = patient.firstName
        }
    }

}
