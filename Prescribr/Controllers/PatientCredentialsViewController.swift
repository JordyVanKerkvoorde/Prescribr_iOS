//
//  PatientCredentialsViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 30/12/2020.
//

import UIKit

class PatientCredentialsViewController: UIViewController {

    @IBOutlet var firstname: UITextField!
    @IBOutlet var lastname: UITextField!
    @IBOutlet var weight: UITextField!
    @IBOutlet var height: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    var patient: Patient?
    var isNewPatient: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.setValue(UIColor.cyan, forKey: "textColor")
        datePicker.setValue(false, forKey: "highlightsToday")
        
        
    }
    
    func setupEditPatient(patient: Patient){
        isNewPatient = false
        self.patient = patient
        
        setPatientFields()
    }
    
    func setPatientFields(){
        firstname.text = patient?.firstName
        lastname.text = patient?.lastName
        weight.text = String(patient?.weightKG ?? 0)
        height.text = String(patient?.heightCM ?? 0)
    }
    
    @IBAction func addPatient(_ sender: Any) {
        if isNewPatient{
            let patientDTO = PatientDTO(firstName: firstname.text!, lastName: lastname.text!, dateOfBirth: convertDate(), heightCM: Int(height.text!) ?? 0, weightKG: Int(weight.text!) ?? 0)
            
            PatientService().addPatient(patientDTO: patientDTO) { (success, fail) in
                if(fail == nil){
                    print(success!)
                } else {
                    print(fail!)
                }
            }
            
            //networkcall addpatient
        } else {
            patient?.firstName = firstname.text!
            patient?.lastName = lastname.text!
            patient?.dateOfBirth = convertDate()
            patient?.heightCM = Int(height.text!) ?? Int(patient?.heightCM ?? 0)
            patient?.weightKG = Int(weight.text!) ?? Int(patient?.weightKG ?? 0)
            
            PatientService().updatePatient(patient: patient!){ (success, fail) in
                if(fail == nil){
                    print(success!)
                } else {
                    print(fail!)
                }
            }
        }
    }
    
    func convertDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        return dateFormatter.string(from: datePicker.date)
    }
}
