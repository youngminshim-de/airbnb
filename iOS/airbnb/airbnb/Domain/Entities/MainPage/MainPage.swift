//
//  MainPage.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/27.
//

import Foundation

struct MainPage: Decodable {
    private (set) var nearbyPlaces: [NearbyPlace]
    private (set) var themes: [Theme]
}
