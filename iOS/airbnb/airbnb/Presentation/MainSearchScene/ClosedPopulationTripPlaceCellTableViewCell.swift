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
    
    private (set) static var  identifier = "ClosedPopulationTripPlaceCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
