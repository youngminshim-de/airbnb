//
//  MainPageDTO + Mapping.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/18.
//

import Foundation

struct MainPageDTO: Decodable {
    private let nearbyPlaces: [NearbyPlaceDTO]
    private let themes: [ThemeDTO]
}

extension MainPageDTO {
    struct NearbyPlaceDTO: Decodable {
        private let placeId: Int
        private let placeName: String
        private let imageUrl: String
        
        func toDomain() -> NearbyPlace {
            return .init(placeId: placeId, placeName: placeName, imageUrl: imageUrl)
        }
    }
    
    private func toDomainNearbyPlace() -> [NearbyPlace] {
        let places = nearbyPlaces.map{ nearbyPlaceDTO in
            nearbyPlaceDTO.toDomain()
        }
        return places
    }
    
    func toDomain() -> MainPage {
        return .init(nearbyPlaces: toDomainNearbyPlace(), themes: toDomainTheme())
    }
}

extension MainPageDTO {
    struct ThemeDTO: Decodable {
        private let themeId: Int
        private let themeName: String
        private let imageUrl: String
        
        func toDomain() -> Theme {
            return .init(themeId: themeId, themeName: themeName, imageUrl: imageUrl)
        }
    }
    
    private func toDomainTheme() -> [Theme] {
        let theme = themes.map{ themeDTO in
            themeDTO.toDomain()
        }
        return theme
    }
}
