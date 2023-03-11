//
//  MapView.swift
//  BucketList
//
//  Created by Don Bouncy on 10/03/2023.
//

import MapKit
import SwiftUI

struct MapView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    @State private var locations = [SavedLocation]()
    
    @State private var selectedLocation: SavedLocation?
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinates){
                    VStack {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        
                        Text(location.name)
                    }
                    .onTapGesture {
                        selectedLocation = location
                    }
                }
            }
            .ignoresSafeArea()
            
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 35, height: 35)
            
            VStack {
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Button {
                        let newLocation = SavedLocation(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        locations.append(newLocation)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .sheet(item: $selectedLocation) { location in
            EditView(location: location) { newLocation in
                if let index = locations.firstIndex(of: location) {
                    locations[index] = newLocation
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
