//
//  ClosedTripPlaceDataSource.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/12.
//

import UIKit

class ClosedTripPlaceDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClosedTripPlaceCell.identifier, for: indexPath) as? ClosedTripPlaceCell else {
            return ClosedTripPlaceCell()
        }
        return cell
    }
    
    
}
