//
//  DIYCalendarCell.swift
//  airbnb
//
//  Created by 심영민 on 2021/08/25.
//

import UIKit
import FSCalendar

enum SelectionType: Int {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}

class DIYCalendarCell: FSCalendarCell {
    weak var circleImageView: UIImageView!
    weak var selectionLayer: CAShapeLayer!
    weak var roundedLayer: CAShapeLayer!
    
    var selectionType: SelectionType = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init!(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        let circleImageView = UIImageView(image: UIImage(named: "circle"))
        self.contentView.insertSubview(circleImageView, at: 0)
        self.circleImageView = circleImageView
        
        let selectionlayer = CAShapeLayer()
        selectionlayer.fillColor = UIColor.systemGray.cgColor
        selectionlayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(selectionlayer, below: self.titleLabel.layer)
        self.selectionLayer = selectionlayer
        
        let roundedlayer = CAShapeLayer()
        roundedlayer.fillColor = UIColor.black.cgColor
        roundedlayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(roundedlayer, below: self.titleLabel.layer)
        self.roundedLayer = roundedlayer
        
        self.shapeLayer.isHidden = true
        let view = UIView(frame: self.bounds)
        self.backgroundView = view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let selectionLayer = selectionLayer, let roundedLayer = roundedLayer else {
            return
        }
        self.backgroundView?.frame = self.bounds.insetBy(dx: 1, dy: 1)
        self.selectionLayer?.frame = self.contentView.bounds
        self.roundedLayer?.frame = self.contentView.bounds

        switch selectionType {
            case .middle:
                self.selectionLayer?.isHidden = false
                self.selectionLayer?.path = UIBezierPath(rect: selectionLayer.bounds).cgPath
                self.roundedLayer?.isHidden = true

            case .leftBorder:
                let selectionRect = selectionLayer.bounds.insetBy(dx: selectionLayer.frame.width / 4, dy: 0.0).offsetBy(dx: selectionLayer.frame.width / 4, dy: 0.0)
                self.selectionLayer?.isHidden = false
                self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath

                let diameter: CGFloat = min(roundedLayer.frame.height, roundedLayer.frame.width)
                let rect = CGRect(x: self.contentView.frame.width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)
                self.roundedLayer?.isHidden = false
                self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath

            case .rightBorder:
                let selectionRect = selectionLayer.bounds.insetBy(dx: selectionLayer.frame.width / 4, dy: 0.0).offsetBy(dx: -selectionLayer.frame.width / 4, dy: 0.0)
                self.selectionLayer?.isHidden = false
                self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath

                let diameter: CGFloat = min(roundedLayer.frame.height, roundedLayer.frame.width)
                let rect = CGRect(x: self.contentView.frame.width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)
                self.roundedLayer?.isHidden = false
                self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath

            case .single:
                self.selectionLayer?.isHidden = true
                self.roundedLayer?.isHidden = false
                let diameter: CGFloat = min(roundedLayer.frame.height, roundedLayer.frame.width)
                self.roundedLayer?.path = UIBezierPath(ovalIn: CGRect(x: self.contentView.frame.width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)).cgPath

            case .none:
                self.circleImageView.isHidden = true
                self.selectionLayer?.isHidden = true
                self.roundedLayer?.isHidden = true
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        if self.isPlaceholder {
            self.eventIndicator.isHidden = true
        }
    }
}
