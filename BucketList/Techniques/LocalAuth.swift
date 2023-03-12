//
//  LocalAuth.swift
//  BucketList
//
//  Created by Don Bouncy on 08/03/2023.
//

import SwiftUI
import LocalAuthentication

struct LocalAuth: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack{
            if isUnlocked{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            } else {
                Text("Unlock")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                if success {
                    isUnlocked = true
                } else {
                    
                }
            }
        } else {
            
        }
    }
}

struct LocalAuth_Previews: PreviewProvider {
    static var previews: some View {
        LocalAuth()
    }
}
