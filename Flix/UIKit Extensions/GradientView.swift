//
//  GradientView.swift
//  Flix
//
//  Created by Nathan Ansel on 8/9/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class GradientView: UIView {
	
	private let gradientLayer = CAGradientLayer()
	
	var colors: [UIColor] = []
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		gradientLayer.frame = layer.bounds
		guard colors.count >= 2 else { return }
		gradientLayer.colors = colors.map { $0.cgColor }
//		gradientLayer.startPoint = .zero
//		gradientLayer.endPoint = CGPoint(x: 0, y: layer.bounds.height)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		gradientLayer.type = kCAGradientLayerAxial
		layer.addSublayer(gradientLayer)
	}
}
