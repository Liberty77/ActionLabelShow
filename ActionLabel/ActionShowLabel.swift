//
//  ActionShowLabel.swift
//  ActionLabel
//
//  Created by mac on 16/7/8.
//  Copyright © 2016年 Gaol. All rights reserved.
//

import UIKit

class ActionShowLabel: UIView {
   
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    var  text: String! {
        
        didSet {
            self.contentLabel.text = text
            self.contentLabel.sizeToFit()
        }
    }
    
    var  textColor: UIColor! {
        
        didSet {
            self.contentLabel.textColor = textColor
        }
    }
    
    var  font: UIFont! {
        didSet{
            self.contentLabel.font = font
            self.contentLabel.sizeToFit()
            var frame = self.frame
            if frame.size.height < font.lineHeight {
                frame.size.height = font.lineHeight
                self.frame = frame
            }
        }
    }
    
    var  speed: CGFloat!
    
    var contentLabel: UILabel!
    var animationBreak = false
    
    override var frame: CGRect {
        didSet {
            
            let maskLayer = CAShapeLayer(layer: layer)
            maskLayer.path = UIBezierPath(rect: self.bounds).CGPath
            self.layer.mask = maskLayer
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentLabel = UILabel()
        contentLabel.sizeToFit()
        contentLabel.backgroundColor = UIColor.clearColor()
        self.addSubview(contentLabel)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(layoutSubviews), name: UIApplicationWillEnterForegroundNotification, object: UIApplication.sharedApplication())
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.animationBreak {
            self.animationPerform()
        }
    }
    
    override func willMoveToWindow(newWindow: UIWindow?) {
        
        super.willMoveToWindow(newWindow)
        self.animationPerform()
    }
    
    
 
    func animationPerform() {
       
        if self.frame.size.width >= self.contentLabel.frame.size.width {
            return
        }
        
        self.contentLabel.layer.removeAllAnimations()
        let space = self.contentLabel.frame.size.width - self.frame.size.width
        
        let keyFrame = CAKeyframeAnimation()
        keyFrame.keyPath = "transform.translation.x"
        keyFrame.values = [0.0, -space, 0.0]
        keyFrame.repeatCount = Float.infinity
        
        
       guard let textLength = self.contentLabel.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) else {return}
        keyFrame.duration = Double(self.speed * CGFloat(textLength))
        keyFrame.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0.5, 0.5)
        keyFrame.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        keyFrame.delegate = self
        self.contentLabel.layer.addAnimation(keyFrame, forKey: nil)
        
    }
    
    //MARK: Delegate
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        self.animationBreak = !flag
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
