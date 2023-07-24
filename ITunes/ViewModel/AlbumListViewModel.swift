//
//  AlbumListViewModel.swift
//  ITunes
//
//  Created by Avinash Kumar on 21/07/23.
//

import Foundation
import Combine

class AlbumListViewModel: ObservableObject {
    
    @Published public var searchTerm: String = ""
    @Published public var albums: [Album] = [Album]()
    
    @Published var state: FetchState = .good
    
    private var limit: Int = 20
    private var page: Int = 0
    
    private let service = APIService()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchAlbums(for: term)
            }.store(in: &subscriptions)
    }
    
    private func clear() {
        state = .good
        albums = []
        page = 0
    }
    
    private func loadMore() {
        fetchAlbums(for: searchTerm)
    }
    
    private func fetchAlbums(for searchTerm: String) {
        
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.good else {
            return
        }
        
        state = .isLoading
        
        service.fetchAlbums(searchTerm: searchTerm, page: page, limit: limit) { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let results):
                        for album in results.results {
                            self?.albums.append(album)
                        }
                        self?.page += 1
                        self?.state = (results.results.count == self?.limit) ? .good : .loadedAll
                        print("fetched albums \(results.resultCount)")
                        
                    case .failure(let error):
                        print("error loading albums: \(error)")
                        self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static public func example() -> AlbumListViewModel {
        let vm = AlbumListViewModel()
        vm.albums = [Album.example()]
        return vm
    }
    
}
