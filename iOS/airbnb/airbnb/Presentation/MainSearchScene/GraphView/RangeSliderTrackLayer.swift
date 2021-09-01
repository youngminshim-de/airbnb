import UIKit

class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?
    let values: [CGFloat] = [20, 30, 50, 25, 30, 40, 100, 15, 80, 70, 10, 30, 20, 50, 100, 10, 10, 27, 35, 75, 43, 33, 50, 20, 0]
    
    override func draw(in ctx: CGContext) {
        guard let slider = rangeSlider else {
            return
        }
        let lowerValuePosition = slider.positionForValue(slider.lowerValue)
        let upperValuePosition = slider.positionForValue(slider.upperValue)
        
        let graphPath = UIBezierPath()
        let rangePath = UIBezierPath()
        let xOffset: CGFloat = self.bounds.width / CGFloat(values.count)
        var currentX: CGFloat = 0
        
        graphPath.move(to: CGPoint(x: currentX, y: self.frame.height))
        rangePath.move(to: CGPoint(x: lowerValuePosition, y: self.frame.height))
        for value in values {
            currentX += xOffset
            let newPosition = CGPoint(x: currentX, y: self.frame.height - value)
            
            graphPath.addLine(to: newPosition)
            
            // 현재 포지션이 lowerValue 와 upperValue의 사이에 있을때
            if lowerValuePosition <= currentX && upperValuePosition >= currentX {
                rangePath.addLine(to: newPosition)
            }
        }
        // 마지막 0 으로 내려주기 위해
        rangePath.addLine(to: CGPoint(x: upperValuePosition, y: self.frame.height))
        
        ctx.addPath(graphPath.cgPath)
        ctx.setFillColor(UIColor.systemGray4.cgColor)
        ctx.fillPath()
        
        ctx.addPath(rangePath.cgPath)
        ctx.setFillColor(UIColor.black.cgColor)
        ctx.fillPath()
    }
}
