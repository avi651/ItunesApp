//
//  EntityType.swift
//  ITunes
//
//  Created by Avinash Kumar on 21/07/23.
//

import Foundation

enum EntityType: String, Identifiable, CaseIterable {
    case all
    case album
    case song
    case movie
    
    var id: String {
        self.rawValue
    }
    
    internal func name() -> String {
        switch self {
        case .all:
             return "All"
        case .album:
            return "Albums"
        case .song:
            return "Songs"
        case .movie:
            return "Movies"
        }
    }
}
