//
//  AccomodationSearchViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/16.
//

import UIKit

class AccommodationSearchViewController: UITableViewController {
    
}

extension AccommodationSearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClosedPopulationTripPlaceCellTableViewCell", for: indexPath) as? ClosedPopulationTripPlaceCellTableViewCell else {
            return ClosedPopulationTripPlaceCellTableViewCell()
        }
        
        return cell
    }
}
