//
//  TweetFilterViewModel.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/04.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable  {
    case tweets
    case replies
    case likes
    
    var title: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Replies"
        case .likes: return "Likes"
        }
    }
}
