//
//  ColorWheel.swift
//  ColorWheel
//
//  Created by Tommie N. Carter, Jr., MBA on 4/9/15.
//  Copyright (c) 2015 MING Technology. All rights reserved.
//

import UIKit


struct ColorPath {
    var Path:UIBezierPath
    var Color:UIColor
}


@IBDesignable
class ColorWheel: UIView {
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        center = self.center
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        center = self.center
    }
    
    private var image:UIImage? = nil
    private var imageView:UIImageView? = nil
    private var paths = [ColorPath]()
    
    @IBInspectable var size:CGSize = CGSize.zero { didSet { setNeedsDisplay()} }
    @IBInspectable var sectors:Int = 360 { didSet { setNeedsDisplay()} }
    
    func colorAtPoint ( point: CGPoint) -> UIColor {
        for colorPath in 0..<paths.count {
            if paths[colorPath].Path.contains(point) {
                return paths[colorPath].Color
            }
        }
        return UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        let radius = CGFloat ( min(bounds.size.width, bounds.size.height) / 2.0 ) * 0.90
        let angle:CGFloat = CGFloat(2.0) *  (.pi) / CGFloat(sectors)
        var colorPath:ColorPath = ColorPath(Path:UIBezierPath(), Color:UIColor.clear)
        self.center = CGPoint(x: self.bounds.width - (self.bounds.width / 2.0),y: self.bounds.height - (self.bounds.height / 2.0) )
        UIGraphicsBeginImageContextWithOptions(CGSize(width: bounds.size.width, height: bounds.size.height), false, 0)
        UIColor.white.setFill()
        UIRectFill(frame)
        for sector in 0..<sectors {
            let center = self.center
            colorPath.Path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(sector) * angle, endAngle: (CGFloat(sector) + CGFloat(1)) * angle, clockwise: true)
            colorPath.Path.addLine(to: center)
            colorPath.Path.close()
            
            let color = UIColor(hue: CGFloat(sector)/CGFloat(sectors), saturation: CGFloat(1), brightness: CGFloat(1), alpha: CGFloat(1))
            color.setFill()
            color.setStroke()
            
            colorPath.Path.fill()
            colorPath.Path.stroke()
            colorPath.Color = color

            paths.append(colorPath)
        }
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard image != nil else { return }
        let imageView = UIImageView (image: image)
        self.addSubview(imageView)
        guard let oc = superview?.center else { return }
        imageView.center = oc
        
    }
}


