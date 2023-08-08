//
//  FeedView.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/04.
//

import SwiftUI

struct FeedView: View {
    @State private var showNewTweetView = false
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.tweets) { tweet in
                        TweetRowView(tweet: tweet)
                            .padding()
                    }
                }
            }
            
            Button {
                showNewTweetView.toggle()
            } label: {
                Image(systemName: "plus")
                    .imageScale(.large)
            }
            .frame(width: 60, height: 60)
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $showNewTweetView) {
                NewTweetView()
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
