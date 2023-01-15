//
//  URLSession.swift
//  Cupcake Corner
//
//  Created by Don Bouncy on 08/12/2022.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct URLSessionRequest: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { result in
            VStack(alignment: .leading) {
                /*@START_MENU_TOKEN@*/Text(result.trackName)/*@END_MENU_TOKEN@*/
                    .font(.headline)
                
                Text(result.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=black+sherif&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedData = try? JSONDecoder().decode(Response.self, from: data){
                results = decodedData.results
            }
            
        } catch {
            print("Invalid data")
        }
        
    }
}

struct URLSessionRequest_Previews: PreviewProvider {
    static var previews: some View {
        URLSessionRequest()
    }
}
