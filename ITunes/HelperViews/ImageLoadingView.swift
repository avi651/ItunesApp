//
//  ImageLoadingView.swift
//  ITunes
//
//  Created by Avinash Kumar on 24/07/23.
//

import SwiftUI

struct ImageLoadingView: View {
    
    internal let urlString: String
    internal let size: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)){phase in
            switch phase{
               case .empty:
                   ProgressView().frame(width: size)
            case .failure(_):
                Color.gray.frame(width: size)
            case .success(let image):
                image
                    .border(Color(white: 0.8))
            @unknown default:
                EmptyView()
            }
        }.frame(height: size)
    }
}

struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingView(urlString: "", size: 100)
    }
}
