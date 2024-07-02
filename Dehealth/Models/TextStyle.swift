//
//  TextStyle.swift
//  Dehealth
//
//  Created by apple on 03.06.2024.
//

import Foundation


enum TextStyle {
    case Heading0
    case Heading1
    case Heading2
    case Heading3
    case Heading4
    case Heading5
    case L200
    case L100
    case M200
    case M100
    case S200
    case S100
    case XS200
    case XS100
    case M150
    
    var sizes: Set<Int> {
        switch self {
        case .Heading0:
            return [40,56]
            
        case .Heading1:
            return [32,48]

        case .Heading2:
            return [28,40]
            
        case .Heading3:
            return [24,32]
            
        case .Heading4:
            return [20,32]
            
        case .Heading5:
            return [18,24]
            
        case .L200:
            return [18,24]
            
        case .L100:
            return [18,24]
            
        case .M200:
            return [16,24]
            
        case .M100:
            return [16,24]
            
        case .S200:
            return [14,24]
            
        case .S100:
            return [14,24]
            
        case .XS200:
            return [12,16]
            
        case .XS100:
            return [12,16]
            
        case .M150:
            return [16,24]
            
        }
    }
    
}
