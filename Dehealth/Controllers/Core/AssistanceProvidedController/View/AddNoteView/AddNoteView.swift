//
//  AddNoteView.swift
//  Dehealth
//
//  Created by apple on 01.07.2024.
//

import UIKit

protocol AddNoteViewDelegate: AnyObject {
    func addText(_ text: String)
    func cancel()
    func close()
}

class AddNoteView: UIView {
     //MARK: - Properities
    weak var delegate: AddNoteViewDelegate?
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Нотатки"
        label.font = .interMedium(size: 20)
        return label
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black600
        button.addTarget(self, action: #selector(closeBottonDidTap), for: .touchUpInside)
        return button
    }()
    private let noteView: UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 8
        tv.layer.borderColor = "#DBDBDB".hexColor().cgColor
        tv.layer.borderWidth = 1
        tv.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8 // Adjust the line spacing as needed
        paragraphStyle.alignment = .left // Set text alignment

        let font = UIFont.interLight(size: 16)
//        UIFont(name: "Inter-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: font
        ]

        let attributedText = NSAttributedString(
            string: "",
            attributes: attributes
        )
        tv.attributedText = attributedText
        return tv
    }()
    private lazy var buttonsView: DeleteAddButtonView = {
       let bv = DeleteAddButtonView()
        bv.delegate = self
        return bv
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
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    private func configureUI() {
        backgroundColor = .black700!.withAlphaComponent(0.7)
        addSubview(bgView)
        bgView.anchor(width: 358, height: 286)
        bgView.center(inView: self, yConstant: -50)
        addSubview(titleLabel)
        titleLabel.anchor(top: bgView.topAnchor, left: bgView.leftAnchor, paddingTop: 16, paddingLeft: 16, height: 32)
        addSubview(noteView)
        addSubview(closeButton)
        closeButton.anchor( width: 24, height: 24)
        closeButton.centerY(inView: titleLabel, rightAnchor: bgView.rightAnchor, paddingRight: 16)
        noteView.anchor(top: titleLabel.bottomAnchor, left: bgView.leftAnchor, right: bgView.rightAnchor, paddingTop: 16,  paddingLeft: 16,  paddingRight: 16, height: 150)
        addSubview(buttonsView)
        buttonsView.anchor(top: noteView.bottomAnchor, bottom: bgView.bottomAnchor, right: bgView.rightAnchor, paddingTop: 16, paddingBottom: 16, paddingRight: 16, width: 216)
    }
    @objc
    private func closeBottonDidTap() {
        delegate?.close()
    }
}


extension AddNoteView: DeleteAddButtonViewDelegate {
    func addButtonDidTap() {
        delegate?.addText(noteView.text)
    }
    
    func deleteButtonDidTap() {
        noteView.text = ""
        delegate?.cancel()
    }
    
    
}
