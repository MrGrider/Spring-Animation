//
//  ViewController.swift
//  Kitcast
//
//  Created by Alexander Grischenko on 3/12/18.
//  Copyright © 2018 grider. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let springAnimation: SpringAnimation<CGPoint>
    
    private let springView: SpringView
    private let jumpButton: CircleButton
    private let resetButton: CircleButton

    required init() {
        springView = SpringView()
        jumpButton = CircleButton()
        resetButton = CircleButton()
        springAnimation = SpringAnimation(withView: springView, boundTo: \.center)

        super.init(nibName: nil, bundle: nil)
        
        jumpButton.setTitle("⬆︎", for: .normal)
        jumpButton.setTitleColor(UIColor.white, for: .normal)
        jumpButton.normalColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        jumpButton.highlightedColor = UIColor(red: 68.0/255.0, green: 195.0/255.0, blue: 90.0/255.0, alpha: 1.0)
        jumpButton.addTarget(self, action: #selector(jump(_:)), for: .touchUpInside)

        resetButton.setTitle("↻", for: .normal)
        resetButton.setTitleColor(UIColor.white, for: .normal)
        resetButton.normalColor = UIColor(red: 239.0/255.0, green: 69.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        resetButton.highlightedColor = UIColor(red: 215.0/255.0, green: 62.0/255.0, blue: 95.0/255.0, alpha: 1.0)
        resetButton.addTarget(self, action: #selector(reset(_:)), for: .touchUpInside)
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let defaultMargin: CGFloat = 50.0
    let viewSize: CGFloat = 50.0
    let buttonSize: CGFloat = 50.0

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        springView.bounds = CGRect(x: 0.0, y: 0.0, width: buttonSize, height: buttonSize)

        view.addSubview(springView)
        view.addSubview(jumpButton)
        view.addSubview(resetButton)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let point = CGPoint(x: view.bounds.midX, y: view.bounds.height - defaultMargin * 2.0)
        springAnimation.reset(to: point)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var jumpButtonFrame = CGRect.zero
        jumpButtonFrame.origin.x = view.bounds.width - buttonSize - defaultMargin
        jumpButtonFrame.origin.y = view.bounds.height - buttonSize - defaultMargin
        jumpButtonFrame.size.width = buttonSize
        jumpButtonFrame.size.height = buttonSize
        jumpButton.frame = jumpButtonFrame

        var resetButtonFrame = CGRect.zero
        resetButtonFrame.origin.x = defaultMargin
        resetButtonFrame.origin.y = view.bounds.height - buttonSize - defaultMargin
        resetButtonFrame.size.width = buttonSize
        resetButtonFrame.size.height = buttonSize
        resetButton.frame = resetButtonFrame
    }

    @objc fileprivate func jump(_ sender:UIButton) {
        var point = springView.center
        point.y -= 200.0
        springAnimation.animate(to: point)
    }

    @objc fileprivate func reset(_ sender:UIButton) {
        let point = CGPoint(x: view.bounds.midX, y: view.bounds.height - defaultMargin * 2.0)
        springAnimation.animate(to: point)
    }

}

