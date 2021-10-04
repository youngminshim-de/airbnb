//
//  RecommendTripPlaceDataSource.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/12.
//

import UIKit

class RecommendTripPlaceDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendTripPlaceCell.identifier, for: indexPath) as? RecommendTripPlaceCell else {
            return RecommendTripPlaceCell()
        }
        return cell
    }
    
    
}
