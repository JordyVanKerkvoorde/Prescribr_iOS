//
//  DrugsTableViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 27/12/2020.
//

import UIKit

class DrugsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var drugs: [Drug] = []
    var filteredDrugs: [Drug] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        
        DrugService().getAllDrugs(){ (response, fail) in
            if response != nil {
                self.drugs = response!
            }
            if fail != nil {
                print("Request failed")
            }
            self.filteredDrugs = self.drugs
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDrugs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drug")! as UITableViewCell
        cell.textLabel?.text = filteredDrugs[indexPath.row].name
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredDrugs = []
        if searchText == "" {
            filteredDrugs = drugs
        }else {
            for drug in drugs{
                if drug.name.lowercased().contains(searchText.lowercased()) {
                    filteredDrugs.append(drug)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDrugDetails", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowDrugDetails"){
            let detailViewController = segue.destination as! DrugDetailsViewController
            let index = (self.tableView.indexPathForSelectedRow?.item)!
            let drug = filteredDrugs[index]
            
            detailViewController.drug = drug
        }
    }
}
