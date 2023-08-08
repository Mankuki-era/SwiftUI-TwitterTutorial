//
//  SideMenuView.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/05.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    let user: User
    
    var body: some View {
        
        VStack(alignment: .leading, spacing:  32) {
            VStack(alignment: .leading) {
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.fullname)
                        .font(.headline)
                    
                    Text("@\(user.username)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                UserStatsView()
                    .padding(.vertical)
            }
            .padding(.leading)
            
            ForEach(SideMenuViewModel.allCases, id: \.rawValue) { viewModel in
                if viewModel == .profile {
                    NavigationLink {
                        ProfileView(user: user)
                            .toolbar(.hidden)
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }
                } else if viewModel == .logout {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }

                } else {
                    SideMenuOptionRowView(viewModel: viewModel)
                }
            }
            
            Spacer()
        }
    }
}

//struct SideMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuView()
//    }
//}
