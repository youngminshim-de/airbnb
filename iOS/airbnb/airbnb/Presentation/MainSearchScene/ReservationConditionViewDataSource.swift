//
//  ReservationConditionViewDataSource.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/25.
//

import UIKit

class ReservationConditionViewDataSource: NSObject, UITableViewDataSource {
    enum ReservationCondition: CustomStringConvertible, CaseIterable {
        var description: String {
            switch self {
            case .location:
                return "위치"
            case .checkIn:
                return "체크인/체크아웃"
            case .priceRange:
                return "요금"
            case .guestCount:
                return "인원"
            }
        }
        
        case location, priceRange, checkIn, guestCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReservationCondition.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReservationConditionCell.identifier, for: indexPath) as? ReservationConditionCell else {
            return ReservationConditionCell()
        }
        
        cell.titleLabel.text = ReservationCondition.allCases[indexPath.row].description
        return cell
    }
}
