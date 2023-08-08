//
//  TweetRowViewModel.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/08.
//

import Foundation

class TweetRowViewModel: ObservableObject {
    @Published var tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
        checkIfUserLikedTweet()
    }
    
    func likeTweet() {
        TweetService.likeTweet(tweet) {
            self.tweet.didLike = true
        }
    }
    
    func unlikeTweet() {
        TweetService.unlikeTweet(tweet) {
            self.tweet.didLike = false
        }
    }
    
    func checkIfUserLikedTweet() {
        TweetService.checkIfUserLikedTweet(tweet) { didLike in
            if didLike {
                self.tweet.didLike = true
            }
        }
    }
}
