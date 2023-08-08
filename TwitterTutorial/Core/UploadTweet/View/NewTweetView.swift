//
//  NewTweetView.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/05.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @StateObject var viewModel = UploadTweetViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                
                Spacer()
                
                Button {
                    viewModel.uploadTweet()
                } label: {
                    Text("Tweet")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
            
            HStack(alignment: .top) {
                if let user = AuthService.shared.currentUser {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                }
                
                TextArea("What's happening?", text: $viewModel.caption)
            }
            .padding()
        }
        .onReceive(viewModel.$didUploadTweet) { success in
            if success {
                dismiss()
            }
        }
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
    }
}
