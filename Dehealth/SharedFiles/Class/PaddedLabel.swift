//
//  PaddedLabel.swift
//  Dehealth
//
//  Created by apple on 04.06.2024.
//

import UIKit

class PaddedLabel: UILabel {
    var textPadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

    override func drawText(in rect: CGRect) {
        let paddedRect = rect.inset(by: textPadding)
        super.drawText(in: paddedRect)
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textPadding.left + textPadding.right,
                      height: size.height + textPadding.top + textPadding.bottom)
    }
}
