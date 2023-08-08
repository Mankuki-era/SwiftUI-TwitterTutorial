//
//  AuthHeaderView.swift
//  TwitterTutorial
//
//  Created by Mankuki_era on 2023/08/05.
//

import SwiftUI

struct AuthHeaderView: View {
    let title1: String
    let title2: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
            }
            
            Text(title1)
            
            Text(title2)
        }
        .font(.largeTitle)
        .fontWeight(.semibold)
        .foregroundColor(.white)
        .frame(height: 260)
        .padding(.leading)
        .background(Color(.systemBlue))
        .clipShape(RoundedShape(corners: [.bottomRight]))
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView(title1: "Hello.", title2: "Welcome Back")
    }
}
