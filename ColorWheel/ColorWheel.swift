//
//  ColorWheel.swift
//  ColorWheel
//
//  Created by Tommie N. Carter, Jr., MBA on 4/9/15.
//  Copyright (c) 2015 MING Technology. All rights reserved.
//

import UIKit

@IBDesignable
class ColorWheel: UIView {
    @IBInspectable var sectors: Int = 360 { didSet { setNeedsDisplay() } }

    private var paths: [ColorPath] = []

    func color(at point: CGPoint) -> UIColor {
        if let index = paths.indexOf({ $0.path.containsPoint(point) }) {
            return paths[index].color
        }
        else {
            return UIColor.clearColor()
        }
    }

    override func drawRect(rect: CGRect) {
        let radius = CGFloat(min(bounds.size.width, bounds.size.height) / 2.0) * 0.90
        let angle = CGFloat(2.0) * CGFloat (M_PI) / CGFloat(sectors)
        let center = CGPointMake(self.bounds.width - (self.bounds.width / 2.0), self.bounds.height - (self.bounds.height / 2.0))

        paths = (0..<sectors).map { sector in
            let color = UIColor(hue: CGFloat(sector) / CGFloat(sectors), saturation: 1.0, brightness: 1.0, alpha: 1.0)
            color.setFill()
            color.setStroke()

            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(sector) * angle, endAngle: (CGFloat(sector) + 1.0) * angle, clockwise: true)
            path.addLineToPoint(center)
            path.closePath()
            path.fill()
            path.stroke()

            return ColorPath(path: path, color: color)
        }
    }
}

private struct ColorPath {
    var path: UIBezierPath
    var color: UIColor
}
