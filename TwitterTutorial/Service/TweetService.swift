//
//  TweetService.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/08.
//

import Foundation
import Firebase

struct TweetService {
    
    static func uploadTweet(caption: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data: [String: Any ] = [
            "uid": uid,
            "caption": caption,
            "likes": 0,
            "timestamp": Timestamp(date: Date())
        ]
        
        Firestore.firestore().collection("tweets").document().setData(data) { error in
            if let error = error {
                print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    static func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets").order(by: "timestamp", descending: true).getDocuments { snaphot, _ in
            guard let documents = snaphot?.documents else { return }
            let tweets = documents.compactMap({ try? $0.data(as: Tweet.self) })
            completion(tweets)
        }
    }
    
    static func fetchTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets").whereField("uid", isEqualTo: uid).getDocuments { snaphot, _ in
            guard let documents = snaphot?.documents else { return }
            let tweets = documents.compactMap({ try? $0.data(as: Tweet.self) })
            completion(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
        }
    }
}

// MARK: - Likes

extension TweetService {
    static func likeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes": tweet.likes + 1]) { _ in
            userLikeRef.document(tweetId).setData([:]) { _ in
                completion()
            }
        }
    }
    
    static func unlikeTweet(_ tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        Firestore.firestore().collection("tweets").document(tweetId).updateData(["likes": tweet.likes - 1]) { _ in
            userLikeRef.document(tweetId).delete { _ in
                completion()
            }
        }
    }
    
    static func checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        Firestore.firestore().collection("users").document(uid).collection("user-likes").document(tweetId).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            completion(snapshot.exists)
        }
    }
    
    static func fetchLikedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        Firestore.firestore().collection("users").document(uid).collection("user-likes").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { doc in
                let tweetID = doc.documentID
                
                Firestore.firestore().collection("tweets").document(tweetID).getDocument { snapshot, _ in
                    guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
                    tweets.append(tweet)
                    
                    completion(tweets)
                }
            }
        }
    }
}
