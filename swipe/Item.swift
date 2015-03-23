//
//  Item.swift
//  swipe
//
//  Created by Lucas Louca on 22/03/15.
//  Copyright (c) 2015 Lucas Louca. All rights reserved.
//

import UIKit

class Item {
    let title: String?
    let image: UIImage?
    
    init(title:String, image:UIImage?) {
        self.title = title
        self.image = image
    }
    
    class func allItems() -> [Item] {
        return [
            Item(title: "Milk", image: UIImage(named: "milk.png")),
            Item(title: "Butter", image: UIImage(named: "butter.png")),
            Item(title: "Bread", image: UIImage(named: "bread.png")),
            Item(title: "Milk", image: UIImage(named: "milk.png")),
            Item(title: "Butter", image: UIImage(named: "butter.png")),
            Item(title: "Bread", image: UIImage(named: "bread.png")),
            Item(title: "Milk", image: UIImage(named: "milk.png")),
            Item(title: "Butter", image: UIImage(named: "butter.png")),
            Item(title: "Bread", image: UIImage(named: "bread.png")),
            Item(title: "Milk", image: UIImage(named: "milk.png")),
            Item(title: "Butter", image: UIImage(named: "butter.png")),
            Item(title: "Bread", image: UIImage(named: "bread.png"))
            ]
    }
}
