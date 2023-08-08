//
//  LoginViewModel.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/06.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var didAuthenticateUser = false
    
    private let service = AuthService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    func login() {
        AuthService.shared.login(withEmail: email, password: password)
    }
    
    func setupSubscribers() {        
        service.$didAuthenticateUser.sink { [weak self] didAuthenticateUser in
            self?.didAuthenticateUser = didAuthenticateUser
        }
        .store(in: &cancellables)
    }
    
}
