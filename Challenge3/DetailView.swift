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
                    Text("Works For: \(user.company)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                }
                .padding(.bottom)
                
                Text("Biography: \(user.about)")
                    .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Tags:")
                        .bold()
                    ForEach(user.tags, id: \.self){ tag in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(tag)
                        }
                    }
                }
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Friends:")
                        .bold()
                    ForEach(user.friends){ friend in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(friend.name)
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
                    Text(user.name)
                        .bold()
                    OnlineStatus(online: user.isActive)
                }
            }

        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: .init(id: "", isActive: false, name: "", age: 10, company: "", email: "", address: "", about: "", registered: Date(), tags: [""], friends: [.init(id: "", name: "")]))
    }
}
