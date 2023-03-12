//
//  MapView.swift
//  BucketList
//
//  Created by Don Bouncy on 10/03/2023.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        Group{
            if vm.isUnlocked{
                ZStack{
                    Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations) { location in
                        MapAnnotation(coordinate: location.coordinates){
                            VStack {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundColor(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(Circle())
                                
                                Text(location.name)
                                    .fixedSize()
                            }
                            .onTapGesture {
                                vm.selectedLocation = location
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
                                vm.addLocation()
                            } label: {
                                Image(systemName: "plus")
                                    .padding()
                                    .background(.black.opacity(0.75))
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .clipShape(Circle())
                                    .padding(.trailing)
                            }
                        }
                    }
                }
                .sheet(item: $vm.selectedLocation) { location in
                    EditView(location: location) { newLocation in
                        vm.editLocation(newLocation)
                    }
                }

            } else {
                Button("Unlock"){
                    vm.authenticate()
                }
                .alert("Error Authenticating", isPresented: $vm.error) {
                    Button("Enter passcode") {
                        
                    }
                } message: {
                    Text(vm.errorMessage)
                }
            }
        }
        .onAppear{
            vm.authenticate()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
