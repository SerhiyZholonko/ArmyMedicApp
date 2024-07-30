//
//  Button.swift
//  Dehealth
//
//  Created by apple on 12.07.2024.
//

import UIKit

extension UIButton {
    static func createSegmentedButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        return button
    }
}
