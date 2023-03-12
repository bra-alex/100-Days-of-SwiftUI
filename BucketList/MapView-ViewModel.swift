//
//  MapView-ViewModel.swift
//  BucketList
//
//  Created by Don Bouncy on 11/03/2023.
//

import MapKit
import Foundation
import LocalAuthentication

extension MapView{
    @MainActor class ViewModel: ObservableObject{
        @Published var isUnlocked = false
        @Published var errorMessage = ""
        @Published var error = false
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        
        @Published var selectedLocation: SavedLocation?
        @Published private(set) var locations: [SavedLocation]
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("Saved Locations")
        
        init(){
            do{
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([SavedLocation].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation(){
            let newLocation = SavedLocation(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            
            save()
        }
        
        func editLocation(_ location: SavedLocation){
            guard let selectedLocation else {return}
            if let index = locations.firstIndex(of: selectedLocation) {
                locations[index] = location
                
                save()
            }
        }
        
        func save(){
            do{
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
                
            } catch {
                print("Unable to save data")
            }
        }
        
        func authenticate(){
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
                let reason = "Unlock your data"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                    Task{ @MainActor in
                        if success {
                            self.isUnlocked = true
                        } else {
                            self.error = true
                            self.errorMessage = authError!.localizedDescription
                        }
                    }
                }
            } else {
                
            }
        }
    }
}
