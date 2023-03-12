//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Don Bouncy on 11/03/2023.
//

import Foundation

extension EditView{
    enum Loading{
        case loading, loaded, failed
    }
    
    @MainActor class ViewModel: ObservableObject{
        var location: SavedLocation
        
        @Published var name: String
        @Published var description: String
        
        @Published var loadingState = Loading.loading
        @Published private(set) var pages = [Page]()
        
        init(location: SavedLocation) {
            self.location = location
            self.name = location.name
            self.description = location.description
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
        
        func updateLocation() -> SavedLocation{
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            
            return newLocation
        }
    }
}
