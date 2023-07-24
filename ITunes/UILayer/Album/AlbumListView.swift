//
//  AlbumListView.swift
//  ITunes
//
//  Created by Avinash Kumar on 24/07/23.
//

import SwiftUI

struct AlbumListView: View {
    
    @ObservedObject var viewModel: AlbumListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.albums){ album in
                NavigationLink{
                    
                } label: {
                   AlbumRowView(album: album)
                }
                
                ListPlaceholderRowView(state: viewModel.state, loadMore: viewModel.loadMore)
            }.listStyle(.plain)
        }
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlbumListView(viewModel: AlbumListViewModel.example())
        }
    }
}
