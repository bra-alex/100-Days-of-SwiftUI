//
//  ListView.swift
//  Moonshot
//
//  Created by Don Bouncy on 07/11/2022.
//

import SwiftUI

struct ListView: View {
    let mission: [Mission]
    let astronaut: [String: Astronaut]
    
    var body: some View {
        List{
            ForEach(mission) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronaut: astronaut)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding(.trailing)
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
    }
}

struct ListView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        ListView(mission: missions, astronaut: astronaut)
    }
}
