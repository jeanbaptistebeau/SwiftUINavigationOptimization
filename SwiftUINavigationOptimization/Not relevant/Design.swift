//
//  Extensions.swift
//  Capture
//
//  Created by Jean-Baptiste BEAU on 02/12/2016.
//  Copyright © 2016 Sublime. All rights reserved.
//

import UIKit
import SwiftUI

// MARK: - Colors & Styles

extension Double {
    static let opacity60 = 0.6
    static let opacity30 = 0.3
}

extension Color {
    static let white60 = Color.white.opacity(.opacity60)
    static let white30 = Color.white.opacity(.opacity30)
    
    static let darkBlue = Color(Colors.hexStringToUIColor(hex: "#162472"))
    static let veryDarkBlue = Color(Colors.hexStringToUIColor(hex: "#0B0D21"))
    static let discreteBlue = Color(Colors.hexStringToUIColor(hex: "6C77A7"))
    static let oPurple = Color(Colors.hexStringToUIColor(hex: "5B38D3"))
    static let oLightPurple = Color(Colors.hexStringToUIColor(hex: "9747FF"))
    static let oCyan = Color(Colors.hexStringToUIColor(hex: "79CEF4"))

    static let dangerousRed = Color(Colors.hexStringToUIColor(hex: "EA5E5E"))
    static let successGreen = Color(Colors.hexStringToUIColor(hex: "18A882"))
    
    // get premium button gradient
    static let gradientCyan = Color(Colors.hexStringToUIColor(hex: "3EABD6")).opacity(0.2)
    static let gradientPink = Color(Colors.hexStringToUIColor(hex: "E44297")).opacity(0.2)
}

class Colors {

    static let transparentWhite: UIColor = UIColor(white: 1.0, alpha: Constants.transparentAlpha)
    static let moreTransparentWhite: UIColor = UIColor(white: 1.0, alpha: Constants.moreTransparentAlpha)
    static let mostTransparentWhite: UIColor = UIColor(white: 1.0, alpha: Constants.mostTransparentAlpha)
    
    static let dimmedWhite: UIColor = UIColor(white: 0.8, alpha: 1)
    static let dimmedMoreWhite: UIColor = UIColor(white: 0.6, alpha: 1)

    static let black: UIColor = UIColor(white: 0.1, alpha: 1)
    static let dangerousRed: UIColor = Colors.hexStringToUIColor(hex: "EA5E5E")
    static let successGreen: UIColor = Colors.hexStringToUIColor(hex: "18A882")
    static let warningYellow: UIColor = Colors.hexStringToUIColor(hex: "8E5518")

    static let darkBlue: UIColor = Colors.hexStringToUIColor(hex: "162472")
    static let pink: UIColor = Colors.hexStringToUIColor(hex: "#DD3A80")
    static let lightPink: UIColor = Colors.hexStringToUIColor(hex: "EC4D90")
    static let oLightPurple: UIColor = Colors.hexStringToUIColor(hex: "9747FF")

    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

class Constants {
    static let transparentAlpha: CGFloat = 0.3
    static let moreTransparentAlpha: CGFloat = 0.15
    static let mostTransparentAlpha: CGFloat = 0.05
    
    static let vibrantBackgroundDarkness: CGFloat = 0.2
}

public class Spaces {
    static var paragraph_line_spacing: NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6

        return paragraphStyle
    }
        
    static public let with_border_addition: CGFloat = with_border - 17
    static public let with_border: CGFloat = Device.bigIpad ? 100 : Device.iPad ? 50 : 17

    static public let tabTopInset: CGFloat = 35
    static public let tabBottomInset: CGFloat = 50

    static public let above_header: CGFloat = 90
    
    static public let below_header: CGFloat = 30

    static public let between_cells: CGFloat = Device.iPad ? 30 : 20
    
    static public let bottomInsetRegular: CGFloat = 60
    static public let bottomInsetAboveButton: CGFloat = 130
    
    static public let iPadMaxLabelWidth: CGFloat = 500
    
}

class Device {
    
    static var bigIpad: Bool {
        return max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) >= 1100
    }
    
    static var iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /// iPhone X, iPhone 6, 6s, 7, 8 or smaller.
    static var mediumOrSmallScreenWidth: Bool {
        return UIScreen.main.bounds.width <= 375
    }
    
    /// iPhone 6, 6s, 7, 8 or smaller.
    static var mediumOrSmallScreenHeight: Bool {
        return UIScreen.main.bounds.height <= 667
    }

    /// Screen size is iPhone SE 1, 5, 5s, 5c.
    static var smallSEScreenSize: Bool {
        return UIScreen.main.bounds.width <= 320
    }

}
