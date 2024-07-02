//
//  File.swift
//  Dehealth
//
//  Created by apple on 26.12.2023.
//
//
import Foundation
import UIKit
import QuartzCore


class CircularProgressView: UIView {
	private var progressLayer = CAShapeLayer()
	private var trackLayer = CAShapeLayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureProgressViewToBeCircular()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		configureProgressViewToBeCircular()
	}
	
	var setProgressColor: UIColor = UIColor.red {
		didSet {
			progressLayer.strokeColor = UIColor.systemGray3.cgColor
		}
	}
	
	var setTrackColor: UIColor = UIColor.white {
		didSet {
			trackLayer.strokeColor = UIColor.white.cgColor
		}
	}
	private var viewCGPath: CGPath? {
		return UIBezierPath(
			arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
			radius: (frame.size.width - 0.5) / 2,
			startAngle: CGFloat(-0.5 * Double.pi),
			endAngle: CGFloat(2.0 * Double.pi),
			clockwise: true
		).cgPath
	}
	
	private func configureProgressViewToBeCircular() {
		drawsView(using: trackLayer, startingPoint: 2.0, ending: 1.0)
		drawsView(using: progressLayer, startingPoint: 2.0, ending: 0.0)
	}
	
	private func drawsView(using shape: CAShapeLayer, startingPoint: CGFloat, ending: CGFloat) {
		backgroundColor = UIColor.clear
		layer.cornerRadius = frame.size.width / 2.0
		
		shape.path = viewCGPath
		shape.fillColor = UIColor.clear.cgColor
		shape.strokeColor = setProgressColor.cgColor
		shape.lineWidth = startingPoint
		shape.strokeEnd = ending
		
		layer.addSublayer(shape)
	}
	func setProgressWithAnimation(duration: TimeInterval, value: Float) {
		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.duration = duration
		animation.fromValue = 0
		animation.toValue = value
		animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		animation.autoreverses = true  // Make the animation reverse
		animation.repeatCount = .infinity  // Repeat indefinitely
		
		progressLayer.strokeEnd = CGFloat(value)
		progressLayer.add(animation, forKey: "animateCircle")
	}
	func setProgressWithAnimation(duration: TimeInterval, value: Float, completion: (() -> Void)? = nil) {
		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.duration = duration
		animation.fromValue = 0
		animation.toValue = value
		animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
		
		CATransaction.begin()
		CATransaction.setCompletionBlock {
			completion?()
		}
		
		progressLayer.strokeEnd = CGFloat(value)
		progressLayer.add(animation, forKey: "animateCircle")
		
		CATransaction.commit()
	}
}

