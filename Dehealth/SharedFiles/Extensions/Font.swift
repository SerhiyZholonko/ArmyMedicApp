//
//  Font.swift
//  Dehealth
//
//  Created by apple on 05.02.2024.
//

import UIKit


extension UIFont {
	static func interMedium(size: CGFloat) -> UIFont {
		return UIFont(name: "Inter-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
	}
	static func interLight(size: CGFloat) -> UIFont {
		return UIFont(name: "Inter-Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
	}

	static func interThin(size: CGFloat) -> UIFont {
		return UIFont(name: "Inter-Thin", size: size) ?? UIFont.systemFont(ofSize: size, weight: .thin)
	}

	static func interBold(size: CGFloat) -> UIFont {
		return UIFont(name: "Inter-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
	}

	static func interRegular(size: CGFloat) -> UIFont {
		return UIFont(name: "Inter-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
	}

	static func interExtraBold(size: CGFloat) -> UIFont {
		return UIFont(name: "Inter-ExtraBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
	}

	static func interExtraLight(size: CGFloat) -> UIFont {
		return UIFont(name: "Inter-ExtraLight", size: size) ?? UIFont.systemFont(ofSize: size, weight: .ultraLight)
	}

	static func interBlack(size: CGFloat) -> UIFont {
		return UIFont(name: "Inter-Black", size: size) ?? UIFont.systemFont(ofSize: size, weight: .black)
	}

	static func interSemiBold(size: CGFloat) -> UIFont {
		return UIFont(name: "Inter-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
	}
}
