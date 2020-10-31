//
//  HomeView.swift
//  login-ui
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    @AppStorage("status") var logged = false
    
    var body: some View {
        VStack(spacing: 15) {
            
            Text("User Logged In as \(Auth.auth().currentUser?.email ?? "")")
            Text("User UID \(Auth.auth().currentUser?.uid ?? "")")
            
            Button(action: {
                try! Auth.auth().signOut()
                withAnimation {
                    logged = false
                }
            }, label: {
                Text("Log out")
                    .fontWeight(.heavy)
            })
        }
    }
}
