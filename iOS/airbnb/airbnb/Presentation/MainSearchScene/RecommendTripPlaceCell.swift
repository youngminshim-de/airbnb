//
//  RecommendTripPlaceCell.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/12.
//

import UIKit

class RecommendTripPlaceCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(recommendTrip: Theme) {
        imageView.load(url: recommendTrip.imageUrl)
        titleLabel.text = recommendTrip.themeName
    }
}
