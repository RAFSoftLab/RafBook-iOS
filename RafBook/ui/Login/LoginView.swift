//
//  MainAppView.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 26.11.24.
//
import SwiftUI

struct LoginView: View {
    
    @State private var viewModel = LoginViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 20) {
            Text("RafBook")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Spacer()
            
            TextField("Username", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding(.horizontal)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: {
                viewModel.login(appState: appState)
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .disabled(viewModel.isLoggingIn)
            
            if viewModel.isLoggingIn {
                ProgressView("Logging in...")
                    .padding()
            }
            
            Spacer()
            
            HStack {
                Button("Forgot Password?") {
                    // Do something
                }
            }
            .padding(.horizontal)
            .font(.footnote)
            
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

#Preview{
    LoginView()
}

