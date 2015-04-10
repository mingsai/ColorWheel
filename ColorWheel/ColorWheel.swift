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
        
        center = super.center
    }
    
    required init(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private var image:UIImage?=nil
    var imageView:UIImageView?=nil
    var paths=[ColorPath]()

    
    @IBInspectable var size:CGSize=CGSizeZero { didSet { setNeedsDisplay()} }
    @IBInspectable var sectors:Int = 360 { didSet { setNeedsDisplay()} }
    
    func colorAtPoint ( point: CGPoint) -> UIColor {
        for colorPath in 0..<paths.count {
            if paths[colorPath].Path.containsPoint(point) {
                return paths[colorPath].Color
            }
        }
        return UIColor.clearColor()
    }
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        var radius = CGFloat ( min(bounds.size.width, bounds.size.height) / 2.0 ) * 0.90
        var angle:CGFloat = CGFloat(2.0) * CGFloat (M_PI) / CGFloat(sectors)
        var colorPath:ColorPath = ColorPath(Path: UIBezierPath(), Color: UIColor.clearColor())
        
        self.center = CGPointMake( self.bounds.width - (self.bounds.width / 2.0), self.bounds.height - (self.bounds.height / 2.0) )
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(bounds.size.width, bounds.size.height),true, 0)
        UIColor.whiteColor().setFill()
        UIRectFill(frame)
        
        for sector in 0..<sectors {
            
            var center = self.center
            
            colorPath.Path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(sector) * angle, endAngle: (CGFloat(sector) + CGFloat(1)) * angle, clockwise: true)
            colorPath.Path.addLineToPoint(center)
            colorPath.Path.closePath()
            
            var color = UIColor(hue: CGFloat(sector)/CGFloat(sectors), saturation: CGFloat(1), brightness: CGFloat(1), alpha: CGFloat(1))
            color.setFill()
            color.setStroke()
        
            colorPath.Path.fill()
            colorPath.Path.stroke()
            colorPath.Color = color

            paths.append(colorPath)
        }
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imageView = UIImageView (image: image)
        self.addSubview(imageView!)
        
    }
}


