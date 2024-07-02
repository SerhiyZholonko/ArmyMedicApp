//
//  GenderToggleButton.swift
//  Dehealth
//
//  Created by apple on 15.02.2024.
//

import UIKit

class GenderToggleButton: UIButton {
	
	// Images for button states
	let maleImage = UIImage(systemName: "NoPickPoint") // replace with your male image
	let femaleImage = UIImage(systemName: "NoPickPoint") // replace with your female image
	
	// Titles for button states
	let maleTitle = "чоловіча"
	let femaleTitle = "жіноча"
	
	// Current gender state
	var isMale: Bool = true {
		didSet {
			updateButtonAppearance()
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addTarget(self, action: #selector(toggleGender), for: .touchUpInside)
		updateButtonAppearance()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		addTarget(self, action: #selector(toggleGender), for: .touchUpInside)
		updateButtonAppearance()
	}
	
	@objc func toggleGender() {
		isMale.toggle()
	}
	
	private func updateButtonAppearance() {
		let image = isMale ? maleImage : femaleImage
		let title = isMale ? maleTitle : femaleTitle
		
		setTitle(title, for: .normal)
		setImage(image, for: .normal)
		
		// Additional styling if needed
		setTitleColor(.black, for: .normal)
		imageView?.contentMode = .scaleAspectFit
		titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
	}
}
