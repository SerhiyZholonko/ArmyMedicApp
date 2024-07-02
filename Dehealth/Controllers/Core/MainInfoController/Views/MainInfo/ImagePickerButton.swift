//
//  ImagePickerButton.swift
//  Dehealth
//
//  Created by apple on 15.02.2024.
//

import UIKit

protocol ImagePickerButtonDelegate: AnyObject {
    func didSelected()
}

class ImagePickerButton: UIImageView {
    weak var delegate: ImagePickerButtonDelegate?
	// Images for button states
	let maleImage = UIImage(named: "NoPickPoint") // Replace with your male image asset name
	let femaleImage = UIImage(named: "PickPoint") // Replace with your female image asset name
	
	// Current selection state
	var isMale: Bool = true
	
	override init(frame: CGRect) {
		super.init(frame: frame)
//		addTarget(self, action: #selector(toggleSelection), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleSelection))
        addGestureRecognizer(tap)
		updateButtonImage()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
//		addTarget(self, action: #selector(toggleSelection), for: .touchUpInside)
		updateButtonImage()
	}
	
	@objc func toggleSelection() {
        print("Touch")
        updateButtonImage()

        delegate?.didSelected()
		print("toggleSelection did touch")
	}
    @objc func toggleDeSelection() {
        print("Touch")

        updateButtonImage()

        delegate?.didSelected()
        print("toggleSelection did touch")
    }
	 func updateButtonImage() {
         isMale.toggle()
		let image = isMale ? maleImage : femaleImage
         self.contentMode = .scaleAspectFit
         self.image = image
//		setImage(image, for: .normal)
//		imageView?.contentMode = .scaleAspectFit
//		adjustsImageWhenHighlighted = false
	}
}


#Preview(traits: .fixedLayout(width: 30, height: 24)){
    ImagePickerButton(frame: .zero)
}
