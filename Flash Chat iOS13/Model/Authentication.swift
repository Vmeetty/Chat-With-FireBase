//
//  Authentication.swift
//  Flash Chat iOS13
//
//  Created by user on 15.04.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import Firebase

protocol AuthenticationDelegate {
    func isAuthorized(_ newUser: Bool)
}

struct Authentication {
    
    var delegat: AuthenticationDelegate?
    
    func registerWithEmail(_ email: String?, andPassword password: String?) {
        if let email = email, let password = password {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    delegat?.isAuthorized(false)
                } else {
                    delegat?.isAuthorized(true)
                }
            }
        }
    }
    
    func loginWithEmail(_ email: String?, andPassword password: String?) {
        if let email = email, let password = password {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    delegat?.isAuthorized(false)
                } else {
                    delegat?.isAuthorized(true)
                }
            }
        }
    }
}
