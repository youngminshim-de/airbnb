//
//  UIImage + Extension.swift
//  airbnb
//
//  Created by 심영민 on 2021/09/10.
//

import UIKit

extension UIImage {
    func adjustedForShareSheetPreviewIconProvider() -> UIImage {
        let replaceTransparencyWithColor = UIColor.black // change as required
        let minimumSize: CGFloat = 40.0  // points

        let format = UIGraphicsImageRendererFormat.init()
        format.opaque = true
        format.scale = self.scale

        let imageWidth = self.size.width
        let imageHeight = self.size.height
        let imageSmallestDimension = max(imageWidth, imageHeight)
        let deviceScale = UIScreen.main.scale
        let resizeFactor = minimumSize * deviceScale  / (imageSmallestDimension * self.scale)

        let size = resizeFactor > 1.0
            ? CGSize(width: imageWidth * resizeFactor, height: imageHeight * resizeFactor)
            : self.size

        return UIGraphicsImageRenderer(size: size, format: format).image { context in
            let size = context.format.bounds.size
            replaceTransparencyWithColor.setFill()
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
