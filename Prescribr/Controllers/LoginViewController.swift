//
//  LoginViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 08/12/2020.
//

import Foundation
import UIKit
import Toast_Swift

class LoginViewController: UIViewController {
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBAction func onLogin(_ sender: Any) {
        var style = ToastStyle()
        style.messageColor = .red
        style.backgroundColor = .cyan
        
        
        AccountService().login(username: username.text!, password: password.text!) { (response, error) in
            if (response != nil) {
                print(response!)
            }
            if (error != nil) {
                //print("The username and password are inorrect!")
                self.view.makeToast("The username and password are inorrect!", duration: 3.0, position: .top, style: style)
                self.username.text = ""
                self.password.text = ""
            }
        }
    }
    
}
