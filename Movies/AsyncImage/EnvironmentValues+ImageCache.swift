//
//  EnvironmentValues+ImageCache.swift
//  EnvironmentValues+ImageCache
//
//  Created by Satish Bandaru on 14/09/21.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TempImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get {
            self[ImageCacheKey.self]
        }
        set {
            self[ImageCacheKey.self] = newValue
        }
    }
}
