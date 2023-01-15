//
//  ContentView.swift
//  Challenge3
//
//  Created by Don Bouncy on 15/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    var body: some View {
        NavigationStack{
            List(users) { user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                    HStack(alignment: .center){
                        Text(user.name)
                        OnlineStatus(online: user.isActive)
                    }
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            Task{
                await loadData()
            }
        }
    }
    
    func loadData() async {

        if !users.isEmpty{
            print(users)
            return
        }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Error fetching data")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedData = try? decoder.decode([User].self, from: data){
                users = decodedData
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
