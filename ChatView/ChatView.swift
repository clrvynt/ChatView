//
//  ChatView.swift
//
//
//
//  Created by KK on 1/19/15.
//  Copyright (c) 2015 KK. All rights reserved.

import UIKit

enum ArrowDirection {
    case Down
    case Up
}

struct ArrowPosition {
    var x: CGFloat
    var arrowDirection: ArrowDirection
}


class ChatView : UIView {
    
    var arrowPosition: ArrowPosition? = nil
    var shapeLayer: CAShapeLayer? = nil
    
    let triangleHeight:CGFloat = 10.0
    let triangleWidth:CGFloat = 30.0
    let cornerRadius: CGFloat = 10.0
    
    init(arrowPosition: ArrowPosition, frame: CGRect) {
        super.init(frame: frame)
        self.arrowPosition = arrowPosition
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func loadView(nibName: String, arrowPosition: ArrowPosition) -> ChatView {
        let chatView = NSBundle.mainBundle().loadNibNamed(nibName, owner: self, options: nil)[0] as ChatView
        
        chatView.arrowPosition = arrowPosition
        return chatView
    }
    
    func getChatPointAndBaseY() -> (CGPoint, CGFloat) {
        let width = self.bounds.size.width;
        let height = self.bounds.size.height;
        var baseY = height
        
        // By default, arrow points down and centered.
        var chatPoint:CGPoint = CGPointMake(width/2, height + triangleHeight)
        
        // If the chat point is not defined, center it and point downwards.
        if let arrowPosition = arrowPosition {
            if arrowPosition.x > width || arrowPosition.x <= 0.0 {
                // return default arrow
            }
            else {
                chatPoint.x = arrowPosition.x
            }
            switch arrowPosition.arrowDirection {
            case .Down:
                chatPoint.y = height + triangleHeight
            case .Up:
                chatPoint.y = -triangleHeight
                baseY = 0
            }
        }
        return (chatPoint, baseY)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let shapeLayer = shapeLayer {
            shapeLayer.removeFromSuperlayer()
        }
        
        UIGraphicsBeginImageContext(self.frame.size)
        let path = UIBezierPath()
        
        let (chatPoint, baseY) = getChatPointAndBaseY()
        path.moveToPoint(chatPoint)
        path.addLineToPoint(CGPoint(x: chatPoint.x - triangleWidth/2, y: baseY ))
        path.addLineToPoint(CGPoint(x: chatPoint.x + triangleWidth/2, y: baseY))
        path.closePath()
        path.fill()
        
        shapeLayer = CAShapeLayer()
        shapeLayer!.fillColor = self.backgroundColor?.CGColor
        shapeLayer!.path = path.CGPath
        self.layer.addSublayer(shapeLayer!)
        self.layer.cornerRadius = cornerRadius
        UIGraphicsEndImageContext()
        
        self.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin
        
    }
}
