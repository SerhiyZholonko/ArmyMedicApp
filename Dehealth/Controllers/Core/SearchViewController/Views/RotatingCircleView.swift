//
//  RotatingCircleView.swift
//  Dehealth
//
//  Created by apple on 01.03.2024.
//

import UIKit

protocol RotatingCircleViewDelegate: AnyObject {
	func startAction()
	func stopAction()
}

class RotatingCircleView: UIView {
 //MARK: - Properties
	
	weak var delegate: RotatingCircleViewDelegate?
	private var backgroundCircleLayer: CAShapeLayer!
	private var foregroundCircleLayer: CAShapeLayer!

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupLayers()
		setupConfigure()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupLayers()
		startAnimating()
	}
	private func setupConfigure() {
		alpha = 0
	}
	private func setupLayers() {
		// Background circle
		backgroundCircleLayer = createCircleLayer(strokeColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1), lineWidth: 6)
		layer.addSublayer(backgroundCircleLayer)

		// Foreground circle
		foregroundCircleLayer = createCircleLayer(strokeColor: "#5E42EC".hexColor(), lineWidth: 6)
		foregroundCircleLayer.strokeStart = 1/9
		foregroundCircleLayer.strokeEnd = 2/5
		layer.addSublayer(foregroundCircleLayer)
	}

	private func createCircleLayer(strokeColor: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
		let circleLayer = CAShapeLayer()
		circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50)).cgPath
		circleLayer.fillColor = UIColor.clear.cgColor
		circleLayer.strokeColor = strokeColor.cgColor
		circleLayer.lineWidth = lineWidth
		circleLayer.frame = CGRect(x: (bounds.width - 50) / 2, y: (bounds.height - 50) / 2, width: 50, height: 50)
		return circleLayer
	}

	 func startAnimating() {
		 delegate?.startAction()
		self.alpha = 1
		// Rotation animation
		let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
		rotationAnimation.fromValue = 0
		rotationAnimation.toValue = 2 * Double.pi
		rotationAnimation.duration = 1
		rotationAnimation.repeatCount = Float.infinity
		foregroundCircleLayer.add(rotationAnimation, forKey: "rotationAnimation")
		
		// Growing animation
		let growAnimation = CABasicAnimation(keyPath: "strokeEnd")
		growAnimation.fromValue = 1/9
		growAnimation.toValue = 1 // Adjust this value to control how much the line grows
		growAnimation.duration = 1
		growAnimation.autoreverses = true // Makes the animation reverse back to the starting value
		growAnimation.repeatCount = Float.infinity
		foregroundCircleLayer.add(growAnimation, forKey: "growAnimation")
	}
	func stopAnimating() {
		delegate?.stopAction()
		self.alpha = 0
		foregroundCircleLayer.removeAnimation(forKey: "rotationAnimation")
		foregroundCircleLayer.removeAnimation(forKey: "growAnimation")
	}
}
