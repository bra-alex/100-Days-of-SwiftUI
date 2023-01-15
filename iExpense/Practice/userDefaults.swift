//
//  userDefaults.swift
//  iExpense
//
//  Created by Don Bouncy on 02/11/2022.
//

import SwiftUI

struct User: Codable{
    let firstName: String
    let lastName: String
}

struct userDefaults: View {
    @State private var user = User(firstName: "Tui", lastName: "Ne ne ba")
//    @AppStorage("num") private var num = 0
//    @State private var num = UserDefaults.standard.integer(forKey: "tap")
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user){
                UserDefaults.standard.set(data, forKey: "User Data")
            }
        }
//        Button("Tap: \(num)") {
//            num += 1
//            UserDefaults.standard.set(num, forKey: "tap")
//        }
    }
}

struct userDefaults_Previews: PreviewProvider {
    static var previews: some View {
        userDefaults()
    }
}
