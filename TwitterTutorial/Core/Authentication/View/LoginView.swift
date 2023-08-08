//
//  LoginView.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/05.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        //parent container
        NavigationStack {
            VStack {
                // header view
                AuthHeaderView(title1: "Hello.", title2: "Welcome Back")
                
                VStack(spacing: 40) {
                    CustomInputField(imageName: "envelope", placeholderText: "Email", text: $viewModel.email)
                    
                    CustomInputField(imageName: "lock", placeholderText: "Password", isSecureField: true, text: $viewModel.password)
                }
                .padding(.horizontal, 32)
                .padding(.top, 44)
                
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        Text("Reset password view..")
                    } label: {
                        Text("Forgot Password")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemBlue))
                            .padding(.top)
                            .padding(.trailing, 24)
                    }
                }
                
                Button {
                    viewModel.login()
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 340, height: 50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                        .toolbar(.hidden)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                }
                .font(.footnote)
                .padding(.bottom, 32)
                .foregroundColor(Color(.systemBlue))

            }
            .ignoresSafeArea()
            .toolbar(.hidden)
            .navigationDestination(isPresented: $viewModel.didAuthenticateUser) {
                ProfilePhotoSelectorView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
