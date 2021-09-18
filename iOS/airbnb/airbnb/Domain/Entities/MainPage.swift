//
//  MainPage.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/18.
//

import Foundation

struct MainPage: Decodable {
    var nearbyPlaces: [NearbyPlace]
    var themes: [Theme]
}

struct NearbyPlace: Decodable {
    var placeId: Int
    var placeName: String
    var imageUrl: String
}

struct Theme: Decodable {
    var placeId: Int
    var placeName: String
    var imageUrl: String
}
