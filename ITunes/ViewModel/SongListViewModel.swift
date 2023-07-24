//
//  SongListViewModel.swift
//  ITunes
//
//  Created by Avinash Kumar on 24/07/23.
//

import Foundation
import Combine

class SongListViewModel: ObservableObject {
    
    @Published public var searchTerm = ""
    @Published public var songs: [Song] = [Song]()
    @Published public var state: FetchState = .good
    
    private var limit: Int = 20
    private var page: Int = 0
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let service = APIService()
    
    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchSongs(for: term)
            }.store(in: &subscriptions)
    }
    
    internal func clear(){
        state = .good
        songs = []
        page = 0
    }
    
    internal func loadMore() {
        fetchSongs(for: searchTerm)
    }
    
    private func fetchSongs(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.good else {
            return
        }
        
        state = .isLoading
        
        service.fetchSongs(searchTerm: searchTerm, page: page, limit: limit) { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    for songs in results.results {
                        self?.songs.append(songs)
                    }
                    self?.page += 1
                    self?.state = (results.results.count == self?.limit) ? .good : .loadedAll
                    print("fetched songs \(results.resultCount)")
                    
                case .failure(let error):
                    print("Could not load: \(error)")
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
    
    static func example() -> SongListViewModel {
        let vm = SongListViewModel()
        vm.songs = [Song.example()]
        return vm
    }
}
