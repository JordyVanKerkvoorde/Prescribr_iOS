//
//  RegisterViewController.swift
//  Prescribr
//
//  Created by Jordy Van Kerkvoorde on 09/12/2020.
//

import Foundation
import UIKit
import Toast_Swift

class RegisterViewController: UIViewController {
    
    @IBOutlet var firstname: UITextField!
    @IBOutlet var lastname: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var passwordConfirm: UITextField!
    @IBOutlet var signupBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        var style = ToastStyle()
        style.messageColor = .red
        style.backgroundColor = .cyan
        
        if (
            firstname.text == "" ||
            lastname.text == "" ||
            email.text == "" ||
            password.text == "" ||
            passwordConfirm.text == ""
        ){
            self.view.makeToast("All fields must be completed!", duration: 3.0, position: .top, style: style)
        }else if ( password.text != passwordConfirm.text ){
            self.view.makeToast("Passwords don't match!", duration: 3.0, position: .top, style: style)
            password.text = ""
            passwordConfirm.text = ""
        }else if(false){
            //check if email exists!
        }else {
            signupBtn.isEnabled = false
            AccountService().register(email: email.text!,
                                      password: password.text!,
                                      firstname: firstname.text!,
                                      lastname: lastname.text!,
                                      passwordConfirm: passwordConfirm.text!){ (response, fail) in
                if(response != nil){
                    let defaults = UserDefaults.standard
                    defaults.set(response!, forKey: "TOKEN")
                    let token = defaults.string(forKey: "TOKEN")
                    
                    if( token != nil && token != ""){
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let mainTabBarController = storyboard.instantiateViewController(identifier: "tabbar")
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                    }
                }
                if(fail != nil){
                    self.view.makeToast("Something went wrong, please try again later.", duration: 3.0, position: .top, style: style)
                }
            }
        }
    }
    
}
