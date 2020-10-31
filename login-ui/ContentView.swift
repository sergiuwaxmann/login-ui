//
//  ContentView.swift
//  login-ui
//

import SwiftUI
import LocalAuthentication

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
                Home()
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

struct Home : View {
    
    @State var username = ""
    @State var password = ""
    
    // Store for future biometric login
    @AppStorage("stored_User") var user = "waxmann.sergiu@me.com"
    @AppStorage("status") var logged = false
    
    var body: some View {
        VStack {
            
            Spacer(minLength: 0)
            
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 35)
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
            .padding(.leading, 15)
            
            HStack {
                
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                
                TextField("EMAIL", text: $username)
                    .autocapitalization(.none)
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
                
                SecureField("PASSWORD", text: $password)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(password == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.top)
            
            HStack(spacing: 15) {
                
                Button(action: {}, label: {
                    Text("LOGIN")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color("GreenColor"))
                        .clipShape(Capsule())
                })
                .opacity(username != "" && password != "" ? 1 : 0.5)
                .disabled(username != "" && password != "" ? false : true)
                
                if getBiometricsStatus() {
                    Button(action: authenticateUser, label: {
                        Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color("GreenColor"))
                            .clipShape(Circle())
                    })
                }
            }
            .padding(.top)
            
            Button(action: {}, label: {
                Text("Forgot password?")
                    .foregroundColor(Color("GreenColor"))
            })
            .padding(.top, 8)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 5) {
                
                Text("Don't have an account?")
                    .foregroundColor(Color.white.opacity(0.6))
                
                Button(action: {}, label: {
                    Text("Sign up")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("GreenColor"))
                })
            }
            .padding(.vertical)
        }
        .background(Color("BackgroundColor").ignoresSafeArea(.all, edges: .all))
        .animation(.easeOut)
    }
    
    func getBiometricsStatus()->Bool {
        let scanner = LAContext()
        if username == user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
            return true
        }
        return false
    }
    
    func authenticateUser() {
        
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock \(username)") { (status, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            withAnimation(.easeOut) {
                logged = true
            }
        }
    }
    
}
