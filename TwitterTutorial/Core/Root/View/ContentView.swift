//
//  ContentView.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/04.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @State private var showMenu = false
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    @State private var selectedIndex = 0
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
                    .environmentObject(registrationViewModel)
            } else if let _ = viewModel.currentUser {
                mainInterfaceView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    var mainInterfaceView: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                MainTabView(selectedIndex: $selectedIndex)
                    .toolbar(showMenu ? .hidden : .visible)
                
                if showMenu {
                    ZStack {
                        Color(.black)
                            .opacity(showMenu ? 0.25 : 0.0)
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showMenu = false
                        }
                    }
                    .ignoresSafeArea()
                }
                
                SideMenuView(user: viewModel.currentUser!)
                    .frame(width: 300)
                    .offset(x: showMenu ? 0 : -300, y: 0)
                    .background(showMenu ? Color.white : Color.clear)
                
            }
            .navigationTitle(navigationString())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.easeInOut) {
                            showMenu.toggle()
                        }
                    } label: {
                        KFImage(URL(string: viewModel.currentUser!.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                    }

                }
            }
            .onAppear {
                showMenu = false
            }
        }
    }
    
    func navigationString() -> String {
        switch selectedIndex {
        case 0: return "Home"
        case 1: return "Explore"
        case 2: return "Notifications"
        case 3: return "Messages"
        default: return "Home"
        }
    }
}
