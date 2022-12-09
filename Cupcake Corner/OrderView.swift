//
//  OrderView.swift
//  Cupcake Corner
//
//  Created by Don Bouncy on 09/12/2022.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var order: Orders
    
    var body: some View {
        Form {
            Section {
                Picker("Cupcake Type: ", selection: $order.type) {
                    ForEach(Order.types.indices) {
                        Text(Order.types[$0])
                    }
                }
                
                Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
            }
            
            Section {
                Toggle("Special Requests", isOn: $order.specialRequestEnabled.animation())
                
                if order.specialRequestEnabled{
                    Toggle("Extra Frosting", isOn: $order.extraFrosting)
                    Toggle("Sprinkles", isOn: $order.addSprinkles)
                }
            }
            
            Section {
                NavigationLink {
                    AddressView(order: order)
                } label: {
                    Text("Delivery Details")
                }
            }
        }
        .navigationTitle("Cupcake Corner")
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            OrderView(order: Orders())
        }
    }
}
