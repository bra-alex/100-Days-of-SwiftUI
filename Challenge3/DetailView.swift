//
//  DetailView.swift
//  Challenge3
//
//  Created by Don Bouncy on 15/01/2023.
//

import SwiftUI
import Foundation

struct DetailView: View {
    let user: User
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 10){
                    Text("Age: \(user.age)")
                    Text("Works For: \(user.unwrappedCompany)")
                    Text("Email: \(user.unwrappedEmail)")
                    Text("Address: \(user.unwrappedAddress)")
                }
                .padding(.bottom)
                
                Text("Biography: \(user.unwrappedAbout)")
                    .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Tags:")
                        .bold()
                    ForEach(user.tags ?? [], id: \.self){ tag in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(tag)
                        }
                    }
                }
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Friends:")
                        .bold()
                    ForEach(user.friendsArray){ friend in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(friend.unwrappedName)
                        }
                    }
                }
                .padding(.bottom)
            }
            .padding(.leading)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                
                HStack(alignment: .center){
                    Text(user.unwrappedName)
                        .bold()
                    OnlineStatus(online: user.isActive)
                }
            }

        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(user: User(context: moc))
//    }
//}
