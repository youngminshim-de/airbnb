//
//  AccommodationList.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/18.
//

import Foundation

struct AccommodationInformation: Decodable {
    var id: Int
    var title: String
    var images: [String]
    var priceInfo: PriceInfo
    var location: Location
}

struct PriceInfo: Decodable {
    var pricePerNight: Int
    var totalPrice: Int
}

struct Location: Decodable {
    var longitude: Double
    var latitude: Double
    var country: String
    var city: String
    var district: String
}
