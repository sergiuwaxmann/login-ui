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
                Text("Hello World!")
                    .navigationTitle("Home")
                    .navigationBarHidden(false)
                    .preferredColorScheme(.light)
            } else {
                Login()
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
