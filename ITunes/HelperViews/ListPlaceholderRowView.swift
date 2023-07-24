//
//  ListPlaceholderRowView.swift
//  ITunes
//
//  Created by Avinash Kumar on 24/07/23.
//

import SwiftUI

struct ListPlaceholderRowView: View {
    
    internal let state: FetchState
    internal let loadMore: () -> Void
    
    var body: some View {
        switch state {
            case .good:
                Color.clear
                    .onAppear {
                        loadMore()
                    }
            case .isLoading:
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
            case .loadedAll:
                EmptyView()
            case .noResults:
                Text("Sorry Could not find anything.")
                    .foregroundColor(.gray)
            case .error(let message):
                Text(message)
                    .foregroundColor(.pink)
        }
    }
}

struct ListPlaceholderRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListPlaceholderRowView(state: .noResults,
                               loadMore: { })
    }
}
