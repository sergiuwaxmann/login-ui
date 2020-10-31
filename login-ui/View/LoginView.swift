//
//  Login.swift
//  login-ui

import SwiftUI
import LocalAuthentication

struct Login : View {
    
    @StateObject var LoginModel = LoginViewModel()
    
    @AppStorage("stored_user") var storedUser = ""
    @AppStorage("stored_password") var storedPassword = ""
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
                
                TextField("EMAIL", text: $LoginModel.email)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(LoginModel.email == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            
            HStack {
                
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                
                SecureField("PASSWORD", text: $LoginModel.password)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(LoginModel.password == "" ? 0 : 0.12))
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
                .opacity(LoginModel.email != "" && LoginModel.password != "" ? 1 : 0.5)
                .disabled(LoginModel.email != "" && LoginModel.password != "" ? false : true)
                
                if LoginModel.getBiometricsStatus() {
                    Button(action: LoginModel.authenticateUser, label: {
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
    
}
