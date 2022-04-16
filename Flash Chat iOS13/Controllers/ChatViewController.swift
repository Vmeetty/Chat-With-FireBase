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
    
    var allMessages: [Message] = []
    
    var manager = MessageManager()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegat = self
        manager.loadMessage()
        
        let nib = UINib(nibName: K.cellNibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.cellIdentifier)
        tableView.dataSource = self
        
        
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        manager.addDocument(message: messageTextfield.text)
        messageTextfield.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = allMessages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier) as! MessageCell
        let currentUser = Auth.auth().currentUser
        let messageUser = message.sender
        if currentUser?.email == messageUser {
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            cell.bubbleView.backgroundColor = UIColor(named: K.BrandColors.blue)
            cell.textMessage.textColor = UIColor.white
        } else {
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
            cell.bubbleView.backgroundColor = UIColor(named: K.BrandColors.lighBlue)
            cell.textMessage.textColor = UIColor.black
        }
        cell.bubbleView.layer.cornerRadius = cell.bubbleView.frame.height / 3
        cell.textMessage.text = message.body
        return cell
    }
    
}

extension ChatViewController: MessageManagerDelegate {
    
    func getMessages(_ newMessage: Message) {
        allMessages = []
        DispatchQueue.main.async {
            self.allMessages.append(newMessage)
            self.tableView.reloadData()
            let indexPath = IndexPath(item: self.allMessages.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)

        }
    }
    
}
