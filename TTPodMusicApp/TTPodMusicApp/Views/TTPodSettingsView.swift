//
//  TTPodSettingsView.swift
//  TTPodMusicApp
//
//  Created by XING ZHAO on 2023-10-11.
//

import SwiftUI

import SwiftUI

struct TTPodSettingsView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.green
                List {
                    Group {
                        Section(header: Text("General")) {
                            NavigationLink(destination: Text("General Settings")) {
                                Text("General")
                            }
                            
                            NavigationLink(destination: Text("General Settings")) {
                                Text("General")
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    
                    Section(header: Text("Account")) {
                        Divider()
                            .frame(maxHeight: 10)
                        NavigationLink(destination: Text("Account Settings")) {
                            Text("Account")
                        }
                        
                        NavigationLink(destination: Text("Account Settings")) {
                            Text("Account")
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    Section(header: Text("Appearance")) {
                        NavigationLink(destination: Text("Appearance Settings")) {
                            Text("Appearance")
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                .listStyle(GroupedListStyle())
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Settings")
                .toolbarBackground(
                    Color.yellow,
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
        }
    }
}

#Preview {
    TTPodSettingsView()
}
