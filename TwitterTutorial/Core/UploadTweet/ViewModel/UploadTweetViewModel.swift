//
//  UploadTweetViewModel.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/08.
//

import Foundation

class UploadTweetViewModel: ObservableObject {
    @Published var caption = ""
    @Published var didUploadTweet = false
    
    func uploadTweet() {
        TweetService.uploadTweet(caption: caption) { success in
            if success {
                // dismiss screen somehow
                self.didUploadTweet = true
            } else {
                // show error message to user..
            }
        }
    }
}
