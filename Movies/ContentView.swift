//
//  ContentView.swift
//  Movies
//
//  Created by Satish Bandaru on 14/09/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showSettings: Bool = false
    
    var body: some View {
        NavigationView {
            Group {
                HomeTabView()
            }
            .navigationTitle(Text("Movies"))
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(trailing: HStack {
                settingsButton
            })
            .sheet(isPresented: $showSettings) {
                SettingsView(isPresented: $showSettings)
            }
        }
    }
    
    private var settingsButton: some View {
        Button(action: {
            showSettings.toggle()
        }) {
            HStack {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .foregroundColor(.gray)
            }.frame(width: 30, height: 30)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
