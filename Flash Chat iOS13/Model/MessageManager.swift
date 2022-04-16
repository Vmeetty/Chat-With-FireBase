//
//  MessageManager.swift
//  Flash Chat iOS13
//
//  Created by user on 16.04.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import Firebase

protocol MessageManagerDelegate {
    func getMessages(_ newMessage: Message)
}

struct MessageManager {
    
    var delegat: MessageManagerDelegate?
    
    let db = Firestore.firestore()
    
    func loadMessage() {
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if let sender = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String {
                        let newMessage = Message(sender: sender, body: body)
                        self.delegat?.getMessages(newMessage)
                    }
                }
            }
        }
    }
    
    
    func addDocument(message: String?) {
        if let body = message, let user = Auth.auth().currentUser {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : user.email!,
                K.FStore.bodyField   : body,
                K.FStore.dateField   : Date().timeIntervalSince1970
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added")
                }
            }
        }
    }
    
}
