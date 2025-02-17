//
//  ProfileView.swift
//  RafBook
//
//  Created by Stevan Dabizljevic on 8.12.24..
//
import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Replace with actual user profile data
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)

                Text("John Doe")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Faculty Member")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
