//
//  MissionView.swift
//  Moonshot
//
//  Created by Don Bouncy on 05/11/2022.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronaut: [String: Astronaut]
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width * 0.6)
                        .padding(.top)
                    
                    Text(mission.formattedLaunchDate)
                        .padding(.top)
                        .font(.headline)
                    
                    VStack(alignment: .leading) {
                        
                        DividerView()
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        DividerView()
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
                    
                    CrewView(mission: mission, astronauts: astronaut)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronaut: astronaut)
            .preferredColorScheme(.dark)
    }
}
