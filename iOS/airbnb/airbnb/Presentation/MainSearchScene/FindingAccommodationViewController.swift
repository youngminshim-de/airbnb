//
//  FindingAccommodationViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/23.
//

import UIKit

class FindingAccommodationViewController: UIViewController {
    
    weak var coordinator: MainSearchSceneFlowCoordinator?
    private var reservationTableViewDatasource: ReservationConditionViewDataSource
    private let calendarDelegate: CalendarViewDelegate
    private let calendarDataSource: CalendarViewDataSource

    @IBOutlet weak var findingAccommodationConditionView: UIScrollView!
    @IBOutlet weak var condtionStackView: UIStackView!
    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var costGraphView: UIView!
    @IBOutlet weak var costGraph: RangeSlider!
    @IBOutlet weak var peopleCountView: UIView!
    @IBOutlet weak var reservationConditionTableView: UITableView!
    
    required init?(coder: NSCoder) {
        self.reservationTableViewDatasource = ReservationConditionViewDataSource()
        self.calendarDelegate = CalendarViewDelegate()
        self.calendarDataSource = CalendarViewDataSource()
        super.init(coder: coder)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.reservationTableViewDatasource = ReservationConditionViewDataSource()
        self.calendarDelegate = CalendarViewDelegate()
        self.calendarDataSource = CalendarViewDataSource()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reservationConditionTableView.dataSource = reservationTableViewDatasource
        self.calendarView.delegate = calendarDelegate
        self.calendarView.dataSource = calendarDataSource
        scrollView()
    }
    
    override func viewDidLayoutSubviews() {
        costGraph.updateLayerFrames()
    }
    
    static func create() -> FindingAccommodationViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "FindingAccommodationViewController") as? FindingAccommodationViewController else {
            return FindingAccommodationViewController()
        }
        return viewController
    }
    
    func injectionCoordinator(coordinator: MainSearchSceneFlowCoordinator) {
        self.coordinator = coordinator
    }
    
    private func scrollView() {
//        let totalWidth = findingAccommodationConditionView.contentSize.width
        let totalWidth = condtionStackView.frame.width
        let viewCount = condtionStackView.subviews.count
        print(findingAccommodationConditionView.contentSize.width)
        print(totalWidth / CGFloat(viewCount) * 2)
        print(self.view.frame.width)
        print(calendarView.frame.width)
        self.findingAccommodationConditionView.setContentOffset(CGPoint(x: totalWidth / CGFloat(viewCount) * 1, y: 0), animated: true)
    }
}
