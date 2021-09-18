//
//  MainPage.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/18.
//

import Foundation

struct MainPage: Decodable {
    var nearbyPlaces: [nearbyPlace]
    var themes: [theme]
}

struct nearbyPlace: Decodable {
    var placeId: Int
    var placeName: String
    var imageUrl: String
}

struct theme: Decodable {
    var placeId: Int
    var placeName: String
    var imageUrl: String
}
