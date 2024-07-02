//
//  SexView.swift
//  Dehealth
//
//  Created by apple on 14.02.2024.
//

import UIKit

protocol SexViewDelegate: AnyObject {
	func markDidTap()
}

class SexView: UIView {
	//MARK: - Properties
	weak var delegate: SexViewDelegate?
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Стать"
		label.widthAnchor.constraint(equalToConstant: 80).isActive = true
		return label
	}()
   
	private lazy var pointTextView1: PointTextView = {
		let view = PointTextView()
		view.widthAnchor.constraint(equalToConstant: 120).isActive = true
		view.configureCell(title: "чоловіча")
        view.delegate = self
		// Adding Tap Gesture Recognizer
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pointTextView1Tapped))
        
		view.addGestureRecognizer(tapGesture)
		
		return view
	}()


	
	private lazy var pointTextView2: PointTextView = {
		let view = PointTextView()
		view.configureCell(title: "жінача")
        view.delegate = self
      
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pointTextView2Tapped))
        
        view.addGestureRecognizer(tapGesture)
		return view
	}()
	

	
	//MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Functions
	private func configureUI() {
		addSubview(titleLabel)
		titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingLeft: 16, width: 100, height: 48)
		addSubview(pointTextView1)
//        addSubview(pointTextView2)
//
//        pointTextView1.anchor(top: topAnchor, left: titleLabel.rightAnchor, right: pointTextView2.leftAnchor, paddingLeft: 16, paddingRight: 10, height: 48)
//		pointTextView2.anchor(top: topAnchor, left: pointTextView1.rightAnchor, width: 120, height: 48)
	}
	
	
	@objc
	private func pointTextView1Tapped() {
		print("Test touch..")
//        pointTextView1.markImageButton.toggleSelection()
//        pointTextView2.markImageButton.toggleDeSelection()

		// Handle tap on pointTextView1
//        if pointTextView1.markImageButton.isMale {
//            pointTextView1.markImageButton.isMale = false
//            pointTextView2.markImageButton.isMale = true
//            delegate?.markDidTap()
//        } else {
//            pointTextView1.markImageButton.isMale = true
//            pointTextView2.markImageButton.isMale = false
//            delegate?.markDidTap()
//        }
        
//        StorageManager.shared.save(data: true, forKey: .isSex)
        delegate?.markDidTap()


	}
    @objc
    private func pointTextView2Tapped() {
        print("Test touch..")
//        if pointTextView2.markImageButton.isMale {
//            pointTextView1.markImageButton.toggleDeSelection()
//            pointTextView2.markImageButton.toggleSelection()
//        } else {
//            pointTextView1.markImageButton.toggleSelection()
//            pointTextView2.markImageButton.toggleDeSelection()
//        }
        
        // Handle tap on pointTextView1
//        StorageManager.shared.save(data: false, forKey: .isSex)
//        if pointTextView2.markImageButton.isMale {
//            pointTextView1.markImageButton.isMale = false
//            pointTextView2.markImageButton.isMale = true
//
//        } else {
//            pointTextView1.markImageButton.isMale = true
//            pointTextView2.markImageButton.isMale = false
//
//        }
        delegate?.markDidTap()

    }

}


extension SexView: PointTextViewDelegate {
    func markImageButtonDidSelected() {
        //TODO: - make logic switch for select view
       
       

    }
    
	func markDidTap() {
     
		delegate?.markDidTap()
	}
}


#Preview(traits: .fixedLayout(width: 300, height: 60), body: {
    SexView()
})
