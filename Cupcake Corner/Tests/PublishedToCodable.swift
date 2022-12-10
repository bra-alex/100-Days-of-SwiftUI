//
//  Tests.swift
//  Cupcake Corner
//
//  Created by Don Bouncy on 07/12/2022.
//

import SwiftUI

//Make @Published conform to Codable

class User: ObservableObject, Codable{
    enum CodingKeys: CodingKey{
        case name
    }
    
    @Published var name = "Alexander"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct PublishedToCodable: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PublishedToCodable_Previews: PreviewProvider {
    static var previews: some View {
        PublishedToCodable()
    }
}
