//
//  ImageLoader.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/4/25.
//

import Foundation

extension ImageLoader {
    enum LoadingState: Equatable {
        case loading
        case success(Data)
        case failure
    }
}

public class ImageLoader: ObservableObject {
    let cacheManager = CacheManager.shared
    
    @Published var state: LoadingState = .loading
    
    public var url: URL? {
        didSet {
            guard let url = url else {
                return
            }
            Task { @MainActor in
                await fetchImage(url: url)
            }
        }
    }
    
    @MainActor
    func fetchImage(url: URL) async {
        do {
            let imageData = try await cacheManager.load(url: url)
            if let data = imageData {
                state = .success(data)
            }
        } catch {
            // Failed to load
            state = .failure
        }
    }
}
