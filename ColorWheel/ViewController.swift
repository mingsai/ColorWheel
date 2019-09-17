//
//  ViewController.swift
//  ColorWheel
//
//  Created by Tommie N. Carter, Jr., MBA on 4/9/15.
//  Copyright (c) 2015 MING Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorOutput: UIView!
    @IBOutlet weak var colorWheel: ColorWheel!
    @IBAction func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        
        let point = gesture.location(in: colorWheel)
//        println ("\(colorWheel.colorAtPoint(point))")
//        println("\(point)")
        
        colorOutput.backgroundColor = colorWheel.colorAtPoint(point: point)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

