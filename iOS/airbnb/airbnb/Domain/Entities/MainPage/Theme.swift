//
//  Theme.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/18.
//

import Foundation

struct Theme: Decodable {
    private (set) var themeId: Int
    private (set) var themeName: String
    private (set) var imageUrl: String
}
