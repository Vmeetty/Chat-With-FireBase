//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    var auth = Authentication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auth.delegat = self
    }
    
}


//MARK: - Authentication section

extension RegisterViewController: AuthenticationDelegate {
    
    @IBAction func registerPressed(_ sender: UIButton) {
        auth.registerWithEmail(emailTextfield.text, andPassword: passwordTextfield.text)
    }
    
    func isAuthorized(_ newUser: Bool) {
        if newUser {
            self.performSegue(withIdentifier: K.registerSegue, sender: self)
        }
    }
}
