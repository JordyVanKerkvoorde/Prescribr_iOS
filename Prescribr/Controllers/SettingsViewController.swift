//
//  SettingsViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 09/12/2020.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBAction func onLogout(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "TOKEN")
        defaults.removeObject(forKey: "USERMAIL")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginController = storyboard.instantiateViewController(identifier: "login")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginController)
    }
    
}
