//
//  ReservationViewController.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/15.
//

import UIKit

class ReservationViewController: UIViewController {
    @IBOutlet weak var checkInView: UIView!
    @IBOutlet weak var guestCountView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var checkOutLabel: UILabel!
    @IBOutlet weak var guestCountLabel: UILabel!
    @IBOutlet weak var priceAndNightsLabel: UILabel!
    @IBOutlet weak var middlePriceLabel: UILabel!
    @IBOutlet weak var cleaningFeeLabel: UILabel!
    @IBOutlet weak var serviceFeeLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    weak var coordinator: MainSearchSceneFlowCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func reservationButtonTouched(_ sender: UIButton) {
        
    }
    
    static func create() -> ReservationViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(identifier: "ReservationViewController") as? ReservationViewController else {
            return ReservationViewController()
        }
        return viewController
    }
    
    func injectionCoordinator(with coordinator: MainSearchSceneFlowCoordinator) {
        self.coordinator = coordinator
    }
}
