//
//  ClosedTripPlaceCell.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/10.
//

import UIKit

class ClosedTripPlaceCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func configure(closedTrip: NearbyPlace) {
        imageView.load(url: closedTrip.imageUrl)
        placeNameLabel.text = closedTrip.placeName
        distanceLabel.text = "10분 거리"
    }
}
