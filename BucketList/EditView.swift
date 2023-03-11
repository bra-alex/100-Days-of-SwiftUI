//
//  EditView.swift
//  BucketList
//
//  Created by Don Bouncy on 11/03/2023.
//

import SwiftUI

struct EditView: View {
    
    enum Loading{
        case loading, loaded, failed
    }
    
    @Environment(\.dismiss) var dismimss
    
    var location: SavedLocation
    var onSave: (SavedLocation) -> Void
    
    @State private var name: String
    @State private var description: String
    
    @State private var loadingState = Loading.loading
    @State private var pages = [Page]()
    
    init(location: SavedLocation, onSave: @escaping (SavedLocation) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby...") {
                    switch loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.terms?.fullDescription ?? "")
                                .italic()
                        }
                    case .failed:
                        Text("Failed to fetch nearby places")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar{
                Button("Save") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismimss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinates.latitude)%7C\(location.coordinates.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("invalid url")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
            
        } catch {
            loadingState = .failed
            print(String(describing: error))
        }
        
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: SavedLocation.example){ _ in}
    }
}
