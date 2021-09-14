//
//  SettingsView.swift
//  SettingsView
//
//  Created by Satish Bandaru on 14/09/21.
//

import SwiftUI

struct SettingsView: View {
    @State private var selection = 1
    @State private var email = ""
    
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $selection) {
                    Text("Action").tag(1)
                    Text("Comedy").tag(2)
                    Text("Horror").tag(3)
                    Text("Sci-fi").tag(4)
                } label: {
                    Text("Favorite Genre")
                }
                
                Section {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } header: {
                    Text("Email")
                }
                
                Button("Save") {
                    isPresented.toggle()
                }

            }.navigationTitle(Text("Settings"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
    }
}
