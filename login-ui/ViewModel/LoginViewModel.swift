//
//  LoginViewModel.swift
//  login-ui

import SwiftUI
import LocalAuthentication

class LoginViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var alert = false
    @Published var alertMsg = ""
    
    @AppStorage("stored_user") var storedUser = ""
    @AppStorage("stored_password") var storedPassword = ""
    @AppStorage("status") var logged = false
    
    func getBiometricsStatus()->Bool {
        let scanner = LAContext()
        if email == storedUser && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
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
        }
    }
}
