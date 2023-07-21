//
//  ContentView.swift
//  ITunes
//
//  Created by Avinash Kumar on 21/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchTerm: String = ""
    @State private var selectedEntityType = EntityType.all

    
    var body: some View {
        TabView {
            SearchView().tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            AlbumSearchView()
                .tabItem {
                    Label("Albums", systemImage: "music.note")
            }
            
            MovieSearchListView()
                .tabItem {
                    Label("Movies", systemImage: "tv")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
