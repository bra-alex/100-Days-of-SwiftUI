//
//  ButtonsAndAlerts.swift
//  Guess The Flag
//
//  Created by Don Bouncy on 21/10/2022.
//

import SwiftUI

struct ButtonsAndAlerts: View {
    @State private var alert = false
    var body: some View {
        VStack {
            Label("Die", systemImage: "figure.fall")
            Button("Normal") {}
                .buttonStyle(.bordered)
            Button("Destructive", role: .destructive) {}
                .buttonStyle(.bordered)
            Button("Normal Prominent") {}
                .buttonStyle(.borderedProminent)
            Button("Destructive Prominent", role: .destructive) { alert = true }
                .buttonStyle(.borderedProminent)
                .alert("Confirm Delete", isPresented: $alert) {
                    Button("Cancel", role: .cancel) {}
                    Button("Delete", role: .destructive) {}
                } message: {
                    Text("Are you sure you want to delete?")
                }
        }
    }
}

struct ButtonsAndAlerts_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsAndAlerts()
    }
}
