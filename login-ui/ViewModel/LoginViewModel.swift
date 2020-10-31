//
//  LoginViewModel.swift
//  login-ui
//

import SwiftUI
import LocalAuthentication
import Firebase

class LoginViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var alert = false
    @Published var alertMsg = ""
    
    @AppStorage("stored_user") var storedUser = ""
    @AppStorage("stored_password") var storedPassword = ""
    
    @AppStorage("status") var logged = false
    
    @Published var storeInfo = false
    
    @Published var isLoading = false
    
    func getBiometricStatus() -> Bool {
        let scanner = LAContext()
        if email != "" && email == storedUser && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
            return true
        }
        return false
    }
    
    func authenticateUser() {
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock \(email)") { (status, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.password = self.storedPassword
                self.verifyUser()
            }
        }
    }
    
    func verifyUser() {
        
        isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            
            self.isLoading = false
            
            if let error = err {
                self.alertMsg = error.localizedDescription
                self.alert.toggle()
                return
            }
            
            if self.storedUser == "" || self.storedPassword == "" {
                self.storeInfo.toggle()
                return
            }
            
            withAnimation {
                self.logged = true
            }
        }
    }
}
