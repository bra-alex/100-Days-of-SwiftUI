//
//  ValidatingForm.swift
//  Cupcake Corner
//
//  Created by Don Bouncy on 08/12/2022.
//

import SwiftUI

struct ValidatingForm: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableButton: Bool {
        username.isEmpty || email.isEmpty
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            Section {
                Button("Create Account") {
                    print("Creating Account")
                }
                .disabled(disableButton)
            }
        }
    }
}

struct ValidatingForm_Previews: PreviewProvider {
    static var previews: some View {
        ValidatingForm()
    }
}
