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
    @IBOutlet weak var conditionStackView: UIStackView!
    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var costGraphView: UIView!
    @IBOutlet weak var costGraph: RangeSlider!
    @IBOutlet weak var peopleCountView: UIView!
    @IBOutlet weak var reservationConditionTableView: UITableView!
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    private var currentView: CurrentView = .calendarView
    
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
    }
    
    override func viewDidLayoutSubviews() {
        costGraph.updateLayerFrames()
        setButtonState()
    }
        
    static func create() -> FindingAccommodationViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "FindingAccommodationViewController") as? FindingAccommodationViewController else {
            return FindingAccommodationViewController()
        }
        return viewController
    }
    
    func injectionCoordinator(with coordinator: MainSearchSceneFlowCoordinator) {
        self.coordinator = coordinator
    }
    
    private func scrollView() {
        let totalWidth = findingAccommodationConditionView.contentSize.width
        let viewCount = CGFloat(conditionStackView.subviews.count)

        if currentView == .peopleCountView {
            coordinator?.pushAccommodationListCollectionViewController()
        }
        
        setButtonState()
        self.findingAccommodationConditionView.setContentOffset(CGPoint(x: Int(totalWidth / viewCount) * currentView.nextState.rawValue, y: 0), animated: true)
        currentView = currentView.nextState
    }
    
    func setButtonState() {
        nextButton.isEnabled = false
        skipButton.setTitle("건너뛰기", for: .normal)
    }
    
    func changeButtonState() {
        // 데이터가 들어오면 불려야 한다.
        if currentView == .peopleCountView {
            nextButton.setTitle("검색", for: .normal)
        }
        nextButton.isEnabled = true
        skipButton.setTitle("다음", for: .normal)
    }
    
    @IBAction func nextButtonTouched(_ sender: UIButton) {
        if sender.titleLabel!.text == "지우기" {
            setButtonState()
            // ViewMidel 해당 Data nil로 만들기
            return
        }
        scrollView()
    }
}

extension FindingAccommodationViewController {
    enum CurrentView: Int {
        case calendarView = 0, costGraphView, peopleCountView
        
        var nextState: Self {
            switch self {
            case .calendarView:
                return .costGraphView
            case .costGraphView:
                return .peopleCountView
            case .peopleCountView:
                return .peopleCountView
            }
        }
    }
}
