//
//  ViewController.swift
//  swipe
//
//  Created by Lucas Louca on 22/03/15.
//  Copyright (c) 2015 Lucas Louca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var items:[Item]!
    var swipeViews:[SwipeView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = Item.allItems()
        self.loadDraggableCustomViews()
    }
    
    func loadDraggableCustomViews(){
        swipeViews = []
        var swipeView:SwipeView!
        var imageView:UIImageView!
        
        for item in items {
            swipeView = SwipeView(frame:CGRectMake(35, 35, 250, 250))
            imageView = UIImageView(image: item.image)
            imageView.frame = CGRect(x: 0, y: 0, width: swipeView.frame.width, height: swipeView.frame.height)
            swipeView.addSubview(imageView)
            swipeViews.append(swipeView)
            self.view.addSubview(swipeView)
        }
    }

}

