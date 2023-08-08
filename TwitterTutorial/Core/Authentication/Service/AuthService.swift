//
//  AuthService.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/06.
//

import Foundation
import Firebase

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var currentUser: User?
    private var tempUserSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.tempUserSession = user
            
            let data = ["email": email, "username": username.lowercased(), "fullname": fullname, "uid": user.uid]
            Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                self.didAuthenticateUser = true
            }
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
    }
    
    func uploadImage(_ image: UIImage?) async throws {
        guard let uid = tempUserSession?.uid else { return }
        guard let uiImage = image else { return }
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        
        try await Firestore.firestore().collection("users").document(uid).updateData(["profileImageUrl": imageUrl])
        self.userSession = self.tempUserSession
        self.didAuthenticateUser = false
        self.fetchUser()
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        UserService.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
}
