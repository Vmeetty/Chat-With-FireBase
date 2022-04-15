//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var auth = Authentication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auth.delegat = self
    }

}


//MARK: - Authentication section

extension LoginViewController: AuthenticationDelegate {
    
    @IBAction func loginPressed(_ sender: UIButton) {
        auth.loginWithEmail(emailTextfield.text, andPassword: passwordTextfield.text)
    }
    
    func isAuthorized(_ newUser: Bool) {
        if newUser {
            self.performSegue(withIdentifier: K.loginSegue, sender: self)
        }
    }
    
}
