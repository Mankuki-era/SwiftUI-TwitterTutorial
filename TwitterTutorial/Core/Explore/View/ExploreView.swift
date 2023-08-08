//
//  ExploreView.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/04.
//

import SwiftUI

struct ExploreView: View {
    @StateObject var viewModel = ExploreViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding()
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.searchableUsers) { user in
                        NavigationLink {
                            ProfileView(user: user)
                                .toolbar(.hidden)
                        } label: {
                            UserRowView(user: user)
                        }
                    }
                }
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
