//
//  SearchAllListView.swift
//  ITunes
//
//  Created by Avinash Kumar on 24/07/23.
//

import SwiftUI

struct SearchAllListView: View {
    
    @ObservedObject var albumListViewModel: AlbumListViewModel
    @ObservedObject var songListViewModel: SongListViewModel
    @ObservedObject var movieListViewModel: MovieListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 5) {
                if songListViewModel.songs.count > 0 {
                    SectionHeaderView(title: "Songs") {
                        SongListView(viewModel: songListViewModel)
                    }
                    .padding(.top)
                    
                    SongSectionView(songs: songListViewModel.songs)
                    
                    Divider()
                        .padding(.bottom)
                }
            }
        }
    }
}

struct SectionHeaderView<Destination>: View where Destination : View {
    
    let title: String
    let destination:  () -> Destination
    
    init(title: String, @ViewBuilder destination: @escaping () -> Destination) {
        self.title = title
        self.destination = destination
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
            Spacer()
            
            NavigationLink(destination: destination) {
                HStack {
                    Text("See all")
                    Image(systemName: "chevron.right")
                }
            }
        }
        .padding(.horizontal)
    }
}

struct SearchAllListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAllListView(albumListViewModel: AlbumListViewModel.example(),
                          songListViewModel: SongListViewModel.example(),
                          movieListViewModel: MovieListViewModel.example())
    }
}
