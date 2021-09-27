//
//  NearbyPlace.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/18.
//

import Foundation

struct NearbyPlace: Decodable {
    private (set) var placeId: Int
    private (set) var placeName: String
    private (set) var imageUrl: String
}
