import UIKit

class RangeSlider: UIControl {
    
    var minimumValue: CGFloat = 0
    var maximumValue: CGFloat = 1
    var lowerValue: CGFloat = 0
    var upperValue: CGFloat = 1
    var trackTintColor: UIColor = .black
    var trackHighlightTintColor: UIColor = .systemGray4
    
    let thumbImage = UIImage(named: "pause-circle") ?? UIImage()
    
    private let trackLayer = RangeSliderTrackLayer()
    private let lowerThumbImageView = UIImageView()
    private let upperThumbImageView = UIImageView()
    
    private var previousLocation = CGPoint()
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        lowerThumbImageView.image = thumbImage
        lowerThumbImageView.tintColor = .systemGray4
        addSubview(lowerThumbImageView)
        
        upperThumbImageView.image = thumbImage
        upperThumbImageView.tintColor = .systemGray4
        addSubview(upperThumbImageView)
    }
    
    func updateLayerFrames() {
        trackLayer.frame = CGRect(origin: bounds.origin, size: bounds.size)
        trackLayer.setNeedsDisplay()
        lowerThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue), size: thumbImage.size)
        upperThumbImageView.frame = CGRect(origin: thumbOriginForValue(upperValue), size: thumbImage.size)
    }
    
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
      let x = positionForValue(value) - thumbImage.size.width / 2.0
        return CGPoint(x: x, y: (bounds.height - (thumbImage.size.height) / 2.0))
    }
    
    func positionForValue(_ value: CGFloat) -> CGFloat {
      return bounds.width * value
    }
}

extension RangeSlider {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        if lowerThumbImageView.frame.contains(previousLocation) {
            lowerThumbImageView.isHighlighted = true
        } else if upperThumbImageView.frame.contains(previousLocation) {
            upperThumbImageView.isHighlighted = true
        }
        return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
        
        previousLocation = location
        
        if lowerThumbImageView.isHighlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue, upperValue: upperValue)
        } else if upperThumbImageView.isHighlighted {
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue, upperValue: maximumValue)
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        updateLayerFrames()
        CATransaction.commit()
        sendActions(for: .valueChanged)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbImageView.isHighlighted = false
        upperThumbImageView.isHighlighted = false
    }
    
    private func boundValue(_ value: CGFloat,
                            toLowerValue lowerValue: CGFloat,
                            upperValue: CGFloat) -> CGFloat {
        return min(max(value, lowerValue), upperValue)
    }
}
