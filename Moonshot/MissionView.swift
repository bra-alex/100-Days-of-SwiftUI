//
//  MissionView.swift
//  Moonshot
//
//  Created by Don Bouncy on 05/11/2022.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width * 0.6)
                        .padding(.top)
                    
                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                    }
                    .padding(.horizontal)
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
    
    static var previews: some View {
        MissionView(mission: missions[0])
            .preferredColorScheme(.dark)
    }
}
