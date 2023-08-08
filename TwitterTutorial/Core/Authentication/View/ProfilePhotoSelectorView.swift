//
//  ProfilePhotoSelectorView.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/06.
//

import SwiftUI
import PhotosUI

struct ProfilePhotoSelectorView: View {
    @StateObject var viewModel = ProfilePhotoSelectorViewModel()
    
    var body: some View {
        VStack {
            AuthHeaderView(title1: "Setup account", title2: "Add a profile photo")
            
            PhotosPicker(selection: $viewModel.selectedImage) {
                if let profileImage = viewModel.profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .padding(.top, 44)
                } else {
                    VStack(spacing: 10) {
                        Image(systemName: "plus")
                            .font(.system(size: 60))
                        
                        Text("Photo")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .overlay(content: {
                        Circle()
                            .stroke(Color(.systemBlue), lineWidth: 4)
                            .frame(width: 180, height: 180)
                    })
                    .padding(.top, 84)
                }
            }
            
            if let _ = viewModel.profileImage {
                Button {
                    Task { try await viewModel.uploadImage() }
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }

            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
