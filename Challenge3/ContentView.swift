//
//  ContentView.swift
//  Challenge3
//
//  Created by Don Bouncy on 15/01/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var users : FetchedResults<User>
    @State private var usersData = [UserModel]()
    var body: some View {
        NavigationStack{
            List(users) { user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                    HStack(alignment: .center){
                        Text(user.unwrappedName)
                        OnlineStatus(online: user.isActive)
                    }
                }
            }
            .listStyle(.plain)
        }
        .task{
            await loadData()
            await MainActor.run{
                usersData.forEach{ userData in
                    let friend = Friend(context: moc)
                    userData.friends.forEach { friendData in
                        friend.id = friendData.id
                        friend.name = friendData.name
                    }
                    friend.user = User(context: moc)
                    friend.user?.id = userData.id
                    friend.user?.isActive = userData.isActive
                    friend.user?.name = userData.name
                    friend.user?.age = Int16(userData.age)
                    friend.user?.company = userData.company
                    friend.user?.email = userData.email
                    friend.user?.address = userData.address
                    friend.user?.about = userData.about
                    friend.user?.registered = userData.registered
                    friend.user?.tags = userData.tags
                    if moc.hasChanges{
                        try? moc.save()
                    }
                }
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Error fetching data")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedData = try? decoder.decode([UserModel].self, from: data){
                usersData = decodedData
            }
            
        } catch {
            print("Could not decode response: \(error.localizedDescription)")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
