//
//  ClosedPopulationTripPlaceCellTableViewCell.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/16.
//

import UIKit

class ClosedPopulationTripPlaceCellTableViewCell: UITableViewCell {

    @IBOutlet weak var tripPlaceImageView: UIImageView!
    @IBOutlet weak var tripPlaceNameLabel: UILabel!
    @IBOutlet weak var tripPlaceDistanceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
