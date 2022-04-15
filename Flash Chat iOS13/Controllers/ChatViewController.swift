//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDataSource {
    
    let messages = [
        Message(sender: "v@v.com", body: "Hi!!!"),
        Message(sender: "f@f.com", body: "Hello")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: K.cellNibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.cellIdentifier)
        tableView.dataSource = self
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let user = Auth.auth().currentUser {
            if let email = user.email {
                print(email)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier) as! MessageCell
        cell.textMessage.text = messages[indexPath.row].body
        return cell
    }
    
}
