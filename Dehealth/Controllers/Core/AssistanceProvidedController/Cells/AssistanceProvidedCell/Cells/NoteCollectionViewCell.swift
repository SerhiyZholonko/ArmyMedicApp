//
//  NoteCollectionViewCell.swift
//  Dehealth
//
//  Created by apple on 05.06.2024.
//

import UIKit

protocol NoteCollectionViewCellDelegate: AnyObject {
    func updateText(string: String, cell: NoteCollectionViewCell)
}
class NoteCollectionViewCell: UICollectionViewCell {
     //MARK: - Properties
    weak var delegate: NoteCollectionViewCellDelegate?
    static let identifier = "NoteCollectionViewCell"
    
    private let noteTextView: UITextView = {
        let tv = UITextView(frame: .zero)
        tv.text = ""
        tv.backgroundColor = .clear
        return tv
    }()
     //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    
    private func configureCell() {
        noteTextView.delegate = self
        contentView.backgroundColor = .black150
        contentView.layer.cornerRadius = 8
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        addSubview(noteTextView)
        noteTextView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 12, paddingBottom: 8, paddingRight: 12)
    }
    func configure(with text: String) {
            noteTextView.text = text
        }
    static func calculateHeight(for text: String, width: CGFloat) -> CGFloat {
          let tempTextView = UITextView()
          tempTextView.text = text
          tempTextView.font = UIFont.systemFont(ofSize: 14) // Make sure this matches your textView font
          tempTextView.frame.size = CGSize(width: width - 32, height: CGFloat.greatestFiniteMagnitude) // Subtract padding
          let size = tempTextView.sizeThatFits(CGSize(width: width - 32, height: CGFloat.greatestFiniteMagnitude))
          return size.height + 24 // Add padding
      }
    func makeTextViewFirstResponder() {
            noteTextView.becomeFirstResponder()
            noteTextView.selectedTextRange = noteTextView.textRange(from: noteTextView.beginningOfDocument, to: noteTextView.endOfDocument)
        }
        
}

extension NoteCollectionViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
            // Handle text changes here
        delegate?.updateText(string: textView.text, cell: self)
        }
}
