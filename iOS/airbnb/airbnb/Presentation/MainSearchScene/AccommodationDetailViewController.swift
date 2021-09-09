//
//  AccommodationDetailViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/08.
//

import UIKit

class AccommodationDetailViewController: UIViewController {
    
    @IBOutlet weak var topHeaderView: UIView!
    @IBOutlet weak var accommodationImageStackView: UIStackView!
    @IBOutlet weak var accommodationImageView: UIImageView!
    @IBOutlet weak var accommodationDetailView: AccommodationDetailView!
    
    weak var coordinator: MainSearchSceneFlowCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccommodationDetailViewController()
        setupImageViews()
    }
    
    static func create() -> AccommodationDetailViewController {
        let stroyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = stroyboard.instantiateViewController(identifier: "AccommodationDetailViewController") as?
                AccommodationDetailViewController else {
            return AccommodationDetailViewController()
        }
        return viewController
    }
    
    private func setupAccommodationDetailViewController() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupImageViews() {
        self.accommodationImageView.image = UIImage(named: "background.png")
        self.accommodationImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.accommodationImageView.translatesAutoresizingMaskIntoConstraints = false
        self.accommodationImageStackView.addArrangedSubview(accommodationImageView)

        let view = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: self.accommodationImageView.frame.width, height: self.accommodationImageView.frame.height)))

        view.image = UIImage(named: "thumbnail.png")
        view.translatesAutoresizingMaskIntoConstraints = false
        accommodationImageStackView.addArrangedSubview(view)
    }
    
    func injectionCoordinator(with coordinator: MainSearchSceneFlowCoordinator) {
        self.coordinator = coordinator
    }
}

extension AccommodationDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let topHeaderViewHeight: CGFloat = 112
        let scrollViewOffset = accommodationDetailView.frame.minY - (topHeaderViewHeight*2) // 127
        if scrollView.contentOffset.y > scrollViewOffset {
            if scrollView.contentOffset.y > topHeaderViewHeight + scrollViewOffset {
                self.topHeaderView.alpha = 1
            } else {
                self.topHeaderView.alpha = (scrollView.contentOffset.y - topHeaderViewHeight) / scrollViewOffset
            }
        } else {
            self.topHeaderView.alpha = 0
        }
    }
}
