//
//  ContentView.swift
//  LocalAuthenticationTutorial
//
//  Created by Jayant Patil on 07/01/25.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("You are authenticated!")
            } else {
                Text("Please authenticate yourself!")
            }
        }
        .onAppear() { authenticate() }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     error: &error) {
            let reason = "Please authenticate yourself to continue."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { success, authenticationError in
                if success {
                    print(success)
                    isUnlocked = true
                } else {
                    print(authenticationError)
                }
            }
        } else {
            print("No biometric authentication available")
        }
    }
}

#Preview {
    ContentView()
}
