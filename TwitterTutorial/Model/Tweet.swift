//
//  Tweet.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/08.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Tweet: Identifiable, Decodable {
    @DocumentID var id: String?
    var caption: String
    var uid: String
    var timestamp: Timestamp
    var likes: Int
    
    var user: User?
    var didLike: Bool? = false
}
