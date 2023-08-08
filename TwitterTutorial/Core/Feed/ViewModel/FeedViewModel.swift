//
//  FeedViewModel.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/08.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    
    init() {
        fetchTweets()
    }
    
    func fetchTweets() {
        TweetService.fetchTweets { tweets in
            self.tweets = tweets
            
            for i in 0 ..< tweets.count {
                let uid = tweets[i].uid
                
                UserService.fetchUser(withUid: uid) { user in
                    self.tweets[i].user = user
                }
            }
            
        }
    }
}
