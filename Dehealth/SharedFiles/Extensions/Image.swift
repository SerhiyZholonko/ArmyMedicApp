//
//  Image.swift
//  Dehealth
//
//  Created by apple on 08.07.2024.
//

import UIKit

//extension UIImage {
//    convenience init(color: UIColor) {
//        let rect = CGRect(x: 0, y: 0, width: 150, height: 30)
//        UIGraphicsBeginImageContext(rect.size)
//        let context = UIGraphicsGetCurrentContext()!
//        context.setFillColor(color.cgColor)
//        context.fill(rect)
//        let image = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        self.init(cgImage: image.cgImage!)
//    }
//}
//
//extension UIImage {
//    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
//        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
//        color.setFill()
//        UIRectFill(CGRect(origin: .zero, size: size))
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        guard let cgImage = image?.cgImage else { return nil }
//        self.init(cgImage: cgImage)
//    }
//}
