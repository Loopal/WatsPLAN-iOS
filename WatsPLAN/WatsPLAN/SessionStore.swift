//
//  SessionStore.swift
//  WatsPLAN
//
//  Created by Jack Zhang on 2020-06-16.
//  Copyright © 2020 Jiawen Zhang. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Combine
import FirebaseFirestore
import Firebase
import MaterialComponents.MaterialSnackbar

class SessionStore : ObservableObject {
    
    let storage = Storage.storage()
    
    @Published var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    @Published var handle: AuthStateDidChangeListenerHandle?
    

    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                )
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }

    func signUp(
        email: String,
        password: String,
        username: String
        ) {
        //Auth.auth().createUser(withEmail: email, password: password, completion: handler)
        Auth.auth().createUser(withEmail: email, password: password) {result, error in
            
            if error == nil && result != nil {
                let credential: AuthCredential = EmailAuthProvider.credential(withEmail: email, password: password)
                let currentUser = Auth.auth().currentUser
                
                // Have to re-Auth before change the user info
                currentUser?.reauthenticate(with: credential, completion: {(authResult, error) in
                    if error == nil {
                    }
                    else{
                        
                    }
                })

                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                
                changeRequest?.commitChanges { error in
                    if error == nil {
                        
                        let currentUser = Auth.auth().currentUser
                        let currentUID = currentUser?.uid
                        
                        if(currentUID != nil){
                            let fileManager = FileManager.default
                            let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                            let storageRef = self.storage.reference(withPath: "userData/" + currentUID!)
                            
                            do {
                                let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
                                for save in (directoryContents.filter{ $0.pathExtension == "save" }) {
                                    let fileRef = storageRef.child(save.lastPathComponent)
                                    let uploadTask = fileRef.putFile(from: save, metadata: nil) { metadata, error in
                                        /*guard let metadata = metadata else {
                                            print(error)
                                            let message = MDCSnackbarMessage()
                                            message.text = "Cloud Sync Fail"
                                            message.duration = 2
                                            MDCSnackbarManager.show(message)
                                            return
                                        }*/
                                        if let error = error {
                                            let message = MDCSnackbarMessage()
                                            message.text = "Cloud Sync Fail"
                                            message.duration = 2
                                            MDCSnackbarManager.show(message)
                                            print(error)
                                        }
                                        else{
                                            let message = MDCSnackbarMessage()
                                            message.text = "Cloud Sync Succeed"
                                            message.duration = 2
                                            MDCSnackbarManager.show(message)
                                        }
                                    }
                                }
                            } catch {
                                print("error load from document")
                            }
                        }
                        
                    }
                    else {
                        guard let message = error?.localizedDescription else { return }
                        print("Error" + message)
                    }
                }
            }
            else if error != nil {
                let message = MDCSnackbarMessage()
                message.text = error?.localizedDescription
                message.duration = 2
                MDCSnackbarManager.show(message)
            }
            
        }
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
