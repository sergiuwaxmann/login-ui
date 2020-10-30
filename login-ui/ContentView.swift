//
//  ContentView.swift
//  login-ui
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            Home()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            
            Spacer(minLength: 0)
            
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
                .padding(.vertical)
            
            HStack {
                
                VStack(alignment: .leading, spacing: 12, content: {
                    
                    Text("Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Please sign in to continue")
                        .foregroundColor(Color.white.opacity(0.5))
                })
                
                Spacer(minLength: 0)
            }
            .padding()
            
            HStack {
                
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                
                TextField("EMAIL", text: $username)
            }
            .padding()
            .background(Color.white.opacity(username == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            
            HStack {
                
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                
                TextField("PASSWORD", text: $password)
            }
            .padding()
            .background(Color.white.opacity(password == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.top)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("LOGIN")
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 150)
                    .background(Color("GreenColor"))
                    .clipShape(Capsule())
            })
            .padding(.top)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Forgot password?")
                    .foregroundColor(Color("GreenColor"))
            })
            .padding(.top, 8)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 5) {
                
                Text("Don't have an account?")
                    .foregroundColor(Color.white.opacity(0.6))
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Sign up")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("GreenColor"))
                })
            }
            .padding(.vertical)
        }
        .background(Color("BackgroundColor").ignoresSafeArea(.all, edges: .all))
    }
}
