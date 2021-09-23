//
//  AccommodationListCell.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/02.
//

import UIKit

class AccommodationListCell: UICollectionViewCell {
    @IBOutlet weak var headerFilterLabel: UILabel!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var accommodationImageView: UIImageView!
    @IBOutlet weak var averageScoreLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var accommodationNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var wishListButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureCell() {
        wishListButton.setImage(UIImage(named: "wishlist"), for: .normal)
        wishListButton.setImage(UIImage(named: "wishlist_selected"), for: .selected)
    }
    
    @IBAction func wishListButtonTouched(_ sender: UIButton) {
        wishListButton.isSelected = !wishListButton.isSelected
    }
}
