//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Don Bouncy on 09/12/2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Orders
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Checkout")
                }
            }
            .disabled(order.completeDetails)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AddressView(order: Orders())
        }
    }
}
