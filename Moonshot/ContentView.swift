//
//  ContentView.swift
//  Moonshot
//
//  Created by Don Bouncy on 05/11/2022.
//

import SwiftUI

struct ContentView: View {
    let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let mission: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var listView = false
    
    var body: some View {
        NavigationStack{
            Group{
                if listView{
                    ListView(mission: mission, astronaut: astronaut)
                } else {
                    GridView(mission: mission, astronaut: astronaut)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar{
                Button {
                    listView.toggle()
                } label: {
                    Image(systemName: listView ? "list.bullet" : "square.grid.2x2")
                        .animation(.default, value: listView)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
