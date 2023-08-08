//
//  RegistrationViewModel.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/06.
//

import Foundation
import Firebase
import Combine

class RegistrationViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var username = ""
    @Published var fullname = ""
    @Published var password = ""
    
    private let service = AuthService.shared
    
    func register() {
        AuthService.shared.register(withEmail: email, password: password, fullname: fullname, username: username)
    }
        
}
