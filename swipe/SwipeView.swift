
import UIKit

enum DisappearDirection {
    case Left
    case Right
}

class SwipeView: UIView {
    var screenSize: CGRect!
    var panGestureRecognizer : UIPanGestureRecognizer!
    var originalPoint:CGPoint!

    override init(frame: CGRect){
        super.init(frame : frame)
        screenSize = UIScreen.mainScreen().bounds
        self.backgroundColor = UIColor.greenColor()
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("swiped:"))
        self.addGestureRecognizer(panGestureRecognizer)
        
        loadStyle()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func loadStyle(){
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSizeMake(5.00, 5.00)
        self.layer.shadowRadius = 5
    }
    
    func shouldShowShadow(show:Bool){
        if (show) {
            self.layer.shadowOpacity = 0.5
        } else {
            self.layer.shadowOpacity = 0.0
        }
    }
    
    func swiped(gestureRecognizer: UIPanGestureRecognizer) {
        let xDistance:CGFloat = gestureRecognizer.translationInView(self).x
        let yDistance:CGFloat = gestureRecognizer.translationInView(self).y

        switch(gestureRecognizer.state){
        case UIGestureRecognizerState.Began:
            self.originalPoint = self.center
            shouldShowShadow(true)
        case UIGestureRecognizerState.Changed:
            
            let rotationStrength:CGFloat = min((xDistance/320),1)
            let rotationAngel:CGFloat = (1.50*CGFloat(M_PI)*CGFloat(rotationStrength) / 15.00)
            let scaleStrength:CGFloat = 1.00 - CGFloat(fabsf(Float(rotationStrength))) / 4.00
            let scale:CGFloat = max(scaleStrength, 0.93);
            
            self.center = CGPointMake(self.originalPoint.x + xDistance, self.originalPoint.y + yDistance)
            
            let transform:CGAffineTransform = CGAffineTransformMakeRotation(rotationAngel)
            let scaleTransform:CGAffineTransform = CGAffineTransformScale(transform, scale, scale)
            self.transform = scaleTransform
            self.backgroundColor = UIColor.redColor()
            
        case UIGestureRecognizerState.Ended:
            let hasMovedToFarLeft = CGRectGetMaxX(self.frame) < screenSize.width / 2
            let hasMovedToFarRight = CGRectGetMinX(self.frame)  > screenSize.width / 2
            if (hasMovedToFarLeft) {
                removeViewFromParentWithAnimation(disappearDirection: .Left)
            } else if (hasMovedToFarRight) {
                removeViewFromParentWithAnimation(disappearDirection: .Right)
            } else {
                self.resetViewPositionAndTransformations()
            }
        default:
            break
        }
    }
    
    func resetViewPositionAndTransformations(){
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: {
            self.center = self.originalPoint
            self.transform = CGAffineTransformMakeRotation(0)
            self.shouldShowShadow(false)
            }, completion: {success in })
    }
    
    func removeViewFromParentWithAnimation(disappearDirection disappearDirection:DisappearDirection){
        var animations:(()->Void)!
        switch disappearDirection {
        case .Left:
            animations = {self.center.x = -self.frame.width}
        case .Right:
            animations = {self.center.x = self.screenSize.width + self.frame.width}
        default:
            break
        }
        
        UIView.animateWithDuration(0.2, animations: animations , completion: {success in self.removeFromSuperview()})
    }
    
}
