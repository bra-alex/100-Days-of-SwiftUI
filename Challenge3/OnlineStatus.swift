//
//  OnlineStatus.swift
//  Challenge3
//
//  Created by Don Bouncy on 15/01/2023.
//

import SwiftUI

struct OnlineStatus: View {
    var online: Bool
    var body: some View {
        Circle()
            .fill(online ? .green : .red)
            .frame(width: 10, height: 10)
    }
}

struct OnlineStatus_Previews: PreviewProvider {
    static var previews: some View {
        OnlineStatus(online: true)
    }
}
