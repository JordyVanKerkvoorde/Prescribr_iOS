//
//  PatientsTableViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 11/12/2020.
//

import UIKit

class PatientsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    public var patients: [Patient] = []
    var filteredPatients: [Patient] = []
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        PatientService().getPatients(){ (response, fail) in
            if response != nil {
                self.patients = response!
                self.filteredPatients = self.patients
            }
            if fail != nil {
                print("REQUEST FAILED")
            }
        
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ShowPatientsDetails")
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPatients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientCell", for: indexPath) as! PatientCell
        let patient = filteredPatients[indexPath.item]
        cell.setName(firstName: patient.firstName, lastName: patient.lastName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowPatientsDetails", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPatientsDetails" {
            let detailViewController = segue.destination as! PatientsDetailViewController
            let index = (self.tableView.indexPathForSelectedRow?.item)!
            let patient = filteredPatients[index]
            
            detailViewController.patient = patient
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPatients = []
        if searchText == "" {
            filteredPatients = patients
        }else {
            for patient in patients{
                let name = "\(patient.firstName) \(patient.lastName)"
                if name.lowercased().contains(searchText.lowercased()) {
                    filteredPatients.append(patient)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    func addNewPatient(patient: Patient){
        patients.append(patient)
        filteredPatients.append(patient)
        tableView.reloadData()
    }
    
    @IBAction func onNewPatient(_ sender: Any) {
        let vc = UIStoryboard(name: "Patients", bundle: nil).instantiateViewController(withIdentifier: "newpatient") as! PatientCredentialsViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension PatientsTableViewController: PatientCredentialsViewControllerDelegate {
    func addPatient(_ patient: Patient) {
        self.addNewPatient(patient: patient)
    }
}
