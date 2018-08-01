//
//  CircleButton.swift
//  Kitcast
//
//  Created by Alexander Grischenko on 3/12/18.
//  Copyright © 2018 grider. All rights reserved.
//

import UIKit

class CircleButton: UIButton {

    var normalColor: UIColor = UIColor.white {
        didSet { backgroundColor = normalColor }
    }
    var highlightedColor: UIColor = UIColor.lightGray

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isHighlighted = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2.0
    }

    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedColor : normalColor
        }
    }
}
