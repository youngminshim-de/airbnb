//
//  MainSearchViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/09.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources

typealias NearbyPlaceSectionModel = SectionModel<Int, NearbyPlace>
typealias ThemeSectionModel = SectionModel<Int, Theme>

class MainSearchViewController: UIViewController{

    @IBOutlet weak var closedTripPlaceCollectionView: UICollectionView!
    @IBOutlet weak var recommendTripPlaceCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topHeaderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topHeaderView: UIView!

    private var mainPageViewModel: MainPageViewModel?
    weak var coordinator: MainSearchSceneFlowCoordinator?
//    private var closedTripPlaceDataSource: ClosedTripPlaceDataSource
//    private var recommendTripPlaceDataSource: RecommendTripPlaceDataSource
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator?.presentSignInViewController()
//        self.closedTripPlaceCollectionView.dataSource = closedTripPlaceDataSource
//        self.recommendTripPlaceCollectionView.dataSource = recommendTripPlaceDataSource
        self.searchBar.searchTextField.backgroundColor = .white
        bindmainPageViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        self.closedTripPlaceDataSource = ClosedTripPlaceDataSource()
//        self.recommendTripPlaceDataSource = RecommendTripPlaceDataSource()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
//        self.closedTripPlaceDataSource = ClosedTripPlaceDataSource()
//        self.recommendTripPlaceDataSource = RecommendTripPlaceDataSource()
        super.init(coder: coder)
    }
    
    func bindmainPageViewModel() {
        mainPageViewModel?.mainPage.map{$0.nearbyPlaces}
        .bind(to: closedTripPlaceCollectionView.rx.items(cellIdentifier: "ClosedTripPlaceCell", cellType: ClosedTripPlaceCell.self)) { row, closedTrip, cell in
            cell.configure(closedTrip: closedTrip)
        }
        .disposed(by: rx.disposeBag)

        mainPageViewModel?.mainPage.map{$0.themes}
        .bind(to: recommendTripPlaceCollectionView.rx.items(cellIdentifier: "RecommendTripPlaceCell", cellType: RecommendTripPlaceCell.self)) { row, recommendTrip, cell in
            cell.configure(recommendTrip: recommendTrip)
        }
        .disposed(by: rx.disposeBag)
    }
    
    // 필요한 ViewModel을 파라미터에 넘겨 ViewController를 초기화 해줘야 한다.
    static func create(with mainPageViewModel: MainPageViewModel) -> MainSearchViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(identifier: "MainSearchViewController") as? MainSearchViewController else {
            return MainSearchViewController()
        }
        viewController.mainPageViewModel = mainPageViewModel
        return viewController
    }
    
    func injectionCoordinator(with coordinator: MainSearchSceneFlowCoordinator) {
        self.coordinator = coordinator
    }
}

extension MainSearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let constant: CGFloat = 112
        let scrollViewOffset = closedTripPlaceCollectionView.superview!.frame.minY - (constant*2)

        if scrollView.contentOffset.y > scrollViewOffset {
            self.topHeaderView.alpha = 1
            if scrollView.contentOffset.y < constant + scrollViewOffset {
                topHeaderViewHeight.constant = scrollView.contentOffset.y - scrollViewOffset
            } else {
                topHeaderViewHeight.constant = constant
            }
        } else {
            topHeaderViewHeight.constant = 0
        }
    }
}

extension MainSearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // AccommodationSearchViewController로 보내야한다.
        coordinator?.pushAccomodationSearchViewController()
        return false
    }
}
