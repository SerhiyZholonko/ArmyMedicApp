//
//  Image.swift
//  Dehealth
//
//  Created by apple on 08.07.2024.
//

import UIKit



extension UIImage {
    convenience init(color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: img!.cgImage!)
    }
    func withRoundedCorners(radius: CGFloat) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        context?.addPath(UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath)
        context?.closePath()
        context?.clip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? self
    }
}

extension UIImage {
    convenience init(color: UIColor, size: CGSize, corners: UIRectCorner, cornerRadius: CGFloat) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size),
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        color.setFill()
        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!)
    }
}
