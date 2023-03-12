//
//  EditView.swift
//  BucketList
//
//  Created by Don Bouncy on 11/03/2023.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismimss
    
    @StateObject private var vm: ViewModel
    
    var onSave: (SavedLocation) -> Void
    
    init(location: SavedLocation, onSave: @escaping (SavedLocation) -> Void) {
        _vm = StateObject(wrappedValue: ViewModel(location: location))
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Place name", text: $vm.name)
                    TextField("Description", text: $vm.description)
                }
                
                Section("Nearby...") {
                    switch vm.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(vm.pages, id: \.pageid) { page in
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
                    let newLocation = vm.updateLocation()
                    
                    onSave(newLocation)
                    dismimss()
                }
            }
            .task {
                await vm.fetchNearbyPlaces()
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: SavedLocation.example){ _ in}
    }
}
