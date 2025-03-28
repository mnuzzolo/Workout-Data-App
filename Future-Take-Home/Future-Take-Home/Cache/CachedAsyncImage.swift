//
//  CachedAsyncImage.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/4/25.
//

import SwiftUI

public struct CachedAsyncImage<Content: View> : View {
    @StateObject private var loader: ImageLoader = ImageLoader()
    
    let content: (AsyncImagePhase) -> Content
    
    private var url: URL?
    
    public init(url: URL?, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.content = content
        self.url = url
    }
    
    public var body: some View {
        ZStack {
            switch loader.state {
            case .loading:
                content(.empty)
            case .success(let data):
                if let image = UIImage(data: data) {
                    content(.success(Image(uiImage: image)))
                } else {
                    content(.failure(CachedAsyncImageError.noData))
                }
            case .failure:
                content(.failure(CachedAsyncImageError.failedToLoad))
            }
        }
        .onAppear() {
            // Load the artwork now that we're coming into view
            self.loader.url = self.url
        }
    }
    
}

extension CachedAsyncImage {
    enum CachedAsyncImageError: Error {
        case failedToLoad
        case noData
    }
}
