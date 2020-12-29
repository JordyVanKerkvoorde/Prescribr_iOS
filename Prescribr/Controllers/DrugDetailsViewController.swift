//
//  DrugDetailsViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 28/12/2020.
//

import UIKit

class DrugDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet var drugDescription: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var drug: Drug!
    
    var interactions: [Drug] = []
    var fileteredInteractions: [Drug] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        setLabels()
        
        DrugService().getDrugList(idList: drug.negativeInteractions){ (success, fail) in
            
            if success != nil {
                self.interactions = success ?? []
                self.fileteredInteractions = self.interactions
            }
            if fail != nil {
                print("Request failed")
            }
            self.tableView.reloadData()
        }
    }
    
    fileprivate func setLabels() {
        self.title = drug.name
        drugDescription.contentMode = .scaleToFill
        drugDescription.numberOfLines = 0
        drugDescription.text = drug.description
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileteredInteractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drug")!
        cell.textLabel?.text = fileteredInteractions[indexPath.item].name
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fileteredInteractions = []
        if searchText == "" {
            fileteredInteractions = interactions
        }else {
            for drug in interactions{
                if drug.name.lowercased().contains(searchText.lowercased()) {
                    fileteredInteractions.append(drug)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
}
