# ColorWheel

(Support for Swift 5.1)

A simple color wheel using Swift.  

Usage:

Add ColorWheel.swift class to your project
Add the ColorWheel class to a generic view on your storyboard
To retrieve tapped color, access the func colorAtPoint(point:CGPoint) via an outlet to the ColorWheel inside of the tap gesture action method.


@IBOutlet weak var colorWheel: ColorWheel!
 
@IBAction func handleTapGesture(gesture: UITapGestureRecognizer) {
        
        var point = gesture.locationInView(colorWheel)
        colorWheel.colorAtPoint(point)
}

License

GPL v.3 see License file for more details. Basically enjoy the free code, improvements are welcome, note the liabilities in the license file. Provided as is with no guarantees.





To test:
Open the sample project and run.
