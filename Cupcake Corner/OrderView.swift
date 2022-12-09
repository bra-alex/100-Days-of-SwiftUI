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
                Picker("Cupcake Type: ", selection: $order.orders.type) {
                    ForEach(Order.types.indices) {
                        Text(Order.types[$0])
                    }
                }
                
                Stepper("Number of cakes: \(order.orders.quantity)", value: $order.orders.quantity, in: 3...20)
            }
            
            Section {
                Toggle("Special Requests", isOn: $order.orders.specialRequestEnabled.animation())
                
                if order.orders.specialRequestEnabled{
                    Toggle("Extra Frosting", isOn: $order.orders.extraFrosting)
                    Toggle("Sprinkles", isOn: $order.orders.addSprinkles)
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
