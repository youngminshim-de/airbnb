//
//  ReservationConditionCell.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/25.
//

import UIKit

class ReservationConditionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    private (set) static var  identifier = "ReservationConditionCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
