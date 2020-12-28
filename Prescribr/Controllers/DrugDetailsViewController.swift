//
//  DrugDetailsViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 28/12/2020.
//

import UIKit

class DrugDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var drugDescription: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var drug: Drug!
    
    var interactions: [Drug]
    var fileteredInteractions: [Drug]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        self.title = drug.name
        drugDescription.contentMode = .scaleToFill
        drugDescription.numberOfLines = 0
        
        drugDescription.text = drug.description
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(drug.negativeInteractions.count)
        return drug.negativeInteractions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drug")!
        cell.textLabel?.text = drug.negativeInteractions[indexPath.item]
        
        print(drug.negativeInteractions[indexPath.item])
        
        return cell
    }
    
}
