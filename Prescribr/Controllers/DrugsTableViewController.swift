//
//  DrugsTableViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 27/12/2020.
//

import UIKit

class DrugsTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DrugService().getAllDrugs(){ (response, fail) in
            if response != nil {
                
            }
            if fail != nil {
                
            }
        }
    }
}
