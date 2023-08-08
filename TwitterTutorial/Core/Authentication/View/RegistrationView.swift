//
//  RegistrationView.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/05.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack {
            // header view
            AuthHeaderView(title1: "Get started.", title2: "Create your account")
            
            VStack(spacing: 40) {
                CustomInputField(imageName: "envelope", placeholderText: "Email", text: $viewModel.email)
                
                CustomInputField(imageName: "person", placeholderText: "Username", text: $viewModel.username)
                
                CustomInputField(imageName: "person", placeholderText: "Full name", text: $viewModel.fullname)
                
                CustomInputField(imageName: "lock", placeholderText: "Password", isSecureField: true, text: $viewModel.password)
            }
            .padding(32)
            
            Button {
                viewModel.register()
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                    
                    Text("Sign In")
                        .fontWeight(.bold)
                }
            }
            .font(.footnote)
            .padding(.bottom, 32)

        }
        .ignoresSafeArea()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
