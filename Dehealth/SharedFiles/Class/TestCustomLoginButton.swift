//
//  File.swift
//  Dehealth
//
//  Created by apple on 26.12.2023.
//


import UIKit

class TestCustomLoginButton: UIButton {
	private var pepead = true
	var progressView: CircularProgressView = {
		let sp = CircularProgressView()
		sp.isHidden = true
		return sp
	}()
	
	var showProgress: Bool = false {
		didSet {
			progressView.isHidden = !showProgress
			if showProgress {
				setTitle("Вхід в систему", for: .normal)
				backgroundColor = "#BB9FF8".hexColor()
				// Animate progress
				let duration: TimeInterval = 3.0
				let progressValue: Float = 0.8
				progressView.setProgressWithAnimation(duration: duration, value: progressValue) {
				}
			} else {
				setTitle("Увійти", for: .normal)
				backgroundColor = "#5E42EC".hexColor()
				
			}
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureButton()
		configureSubviews()
		progressView.isHidden = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureButton() {
		backgroundColor = .systemBlue
		layer.cornerRadius = 16.0
		setTitleColor(.white, for: .normal)
		setTitle("Your Button Title", for: .normal)
	}
	
	let screenWidth = UIScreen.main.bounds.size.width
	
	private func configureSubviews() {
		let progressViewFrame = CGRect(x: screenWidth / 2 - 120, y: 16, width: 15, height: 15)
		progressView = CircularProgressView(frame: progressViewFrame)
		addSubview(progressView)
		
		// Set colors (optional)
		progressView.setProgressColor = UIColor.white
		progressView.setTrackColor = UIColor.lightGray
		
		// Animate progress
		let duration: TimeInterval = 3.0
		let progressValue: Float = 0.8
		progressView.setProgressWithAnimation(duration: duration, value: progressValue) { 
		}
	}
}

