//
//  AccommodationListDTO + Mapping.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/18.
//

import Foundation

struct AccommodationInformationListDTO: Decodable {
    private let body: [AccommodationInformationDTO]
}

extension AccommodationInformationListDTO {
    struct AccommodationInformationDTO: Decodable {
        private let id: Int
        private let title: String
        private let images: [String]
        private let priceInfo: PriceInfoDTO
        private let location: LocationDTO
        
        func toDomain() -> AccommodationInformation {
            .init(id: id, title: title, images: images, priceInfo: priceInfo.toDomain(), location: location.toDomain())
        }
        
        struct PriceInfoDTO: Decodable {
            private let pricePerNight: Int
            private let totalPrice: Int
            
            func toDomain() -> PriceInfo {
                return .init(pricePerNight: pricePerNight, totalPrice: totalPrice)
            }
        }
        
        struct LocationDTO: Decodable {
            private let longitude: Double
            private let latitude: Double
            private let country: String
            private let city: String
            private let district: String
            
            func toDomain() -> Location {
                return .init(longitude: longitude, latitude: latitude, country: country, city: city, district: district)
            }
        }
    }
    
    func toDomain() -> [AccommodationInformation] {
        let accommodations = body.map{ accommodation in
            accommodation.toDomain()
        }
        return accommodations
    }
}
