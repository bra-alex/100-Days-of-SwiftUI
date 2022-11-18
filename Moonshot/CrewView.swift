//
//  CrewView.swift
//  Moonshot
//
//  Created by Don Bouncy on 07/11/2022.
//

import SwiftUI

struct CrewView: View {
    struct CrewMember{
        let role: String
        let astronaut: Astronaut
    }
    
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(crew, id: \.role) { crew in
                    NavigationLink{
                        AstronautView(astronaut: crew.astronaut)
                    } label: {
                        VStack(alignment: .center){
                            Image(crew.astronaut.id)
                                .resizable()
                                .frame(width: 202, height: 150)
                            
                            VStack(alignment: .center) {
                                Text(crew.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                
                                Text(crew.role)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical)
                        }
                    }
                    .background(.lightBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(.lightBackground)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.crew = mission.crew.map{ member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Could not find \(member.name)")
            }
        }
    }
}

struct CrewView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        CrewView(mission: missions[0], astronauts: astronaut)
    }
}
