//
//  ContentView.swift
//  login-ui
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("status") var logged = false
    
    var body: some View {
        
        NavigationView {
            
            if logged {
                HomeView()
                    .navigationTitle("Home")
                    .navigationBarHidden(false)
                    .preferredColorScheme(.light)
            } else {
                LoginView()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
