//
//  User.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/07.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var username: String
    var fullname: String
    var profileImageUrl: String
    let email: String
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == id
    }
}
