//
//  CacheManager.swift
//  Fetch_TakeHome
//
//  Created by Mike Nuzzolo on 3/4/25.
//

import Foundation

public final class CacheManager {
    // Simple cache
    let cache = NSCache<NSString, NSData>()
    
    public static let shared = CacheManager()
    
    @MainActor
    public func load(url: URL) async throws -> Data? {
        if let data = cache.object(forKey: url.absoluteString as NSString) as? Data {
            // Return from cache if found
            return data
        } else {
            do {
                // Fetch image if not found in cache
                let request = URLRequest(url: url)
                let (data, _) = try await URLSession.shared.data(for: request)
                cache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                return data
            } catch {
                throw URLError(.unknown)
            }
        }
    }
}
