//
//  ViewController.swift
//  ChatView
//
//  Created by kk on 1/20/15.
//  Copyright (c) 2015 KK. All rights reserved.
//

import UIKit

class MyChatView : ChatView {
    @IBOutlet weak var someLabel: UILabel!
}

class ViewController: UIViewController {
    
    var chatView: ChatView? = nil
    var popupVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize myChatView
        chatView = MyChatView.loadView("ChatView", arrowPosition: ArrowPosition(x: 0.0, arrowDirection: ArrowDirection.Down))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPushed(sender: UIButton, event: UIEvent) {
        if let chatView = chatView as? MyChatView {
            if popupVisible {
                chatView.removeFromSuperview()
                popupVisible = false
            }
            else {
                // Width of chat triangle is 30 .. so we give it some buffer so triangle doesn't get cut off over corner radius
                chatView.frame = CGRectMake(sender.frame.origin.x - 15, sender.frame.origin.y - 70, sender.frame.width + 30, 60)
                
                // Determine where on the button the touch happened.
                let touch: AnyObject? = event.touchesForView(sender as UIView)?.anyObject()
                let touchPoint = touch!.locationInView(sender)
                chatView.arrowPosition = ArrowPosition(x: touchPoint.x + 15, arrowDirection: ArrowDirection.Down)
                chatView.someLabel.text = "Arrow Position is \(touchPoint.x)"
                self.view.addSubview(chatView)
                popupVisible = true
            }
        }
    }


}

