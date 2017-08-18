//
//  SharedStyleKit.swift
//  Mimica
//
//  Created by Gleb LInnik on 19.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class SharedStyleKit : NSObject {

    //// Cache

    private struct Cache {
        static let mainGradientColor1: UIColor = UIColor(red: 0.988, green: 0.376, blue: 0.212, alpha: 1.000)
        static let mainGradientColor2: UIColor = UIColor(red: 1.000, green: 0.176, blue: 0.333, alpha: 1.000)
        static let calendarCellBgColor: UIColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1.000)
        static let calendarCellBorderColor: UIColor = UIColor(red: 0.890, green: 0.890, blue: 0.890, alpha: 1.000)
        static let calendarCellTitleColor: UIColor = UIColor(red: 0.290, green: 0.290, blue: 0.290, alpha: 1.000)
        static let calendarCellDateColor: UIColor = UIColor(red: 0.643, green: 0.643, blue: 0.643, alpha: 1.000)
        static let loginViewBorderColor: UIColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1.000)
        static let mainGradient: CGGradient = CGGradient(colorsSpace: nil, colors: [SharedStyleKit.mainGradientColor2.cgColor, SharedStyleKit.mainGradientColor1.cgColor] as CFArray, locations: [0, 1])!
    }

    //// Colors

    @objc dynamic public class var mainGradientColor1: UIColor { return Cache.mainGradientColor1 }
    @objc dynamic public class var mainGradientColor2: UIColor { return Cache.mainGradientColor2 }
    @objc dynamic public class var calendarCellBgColor: UIColor { return Cache.calendarCellBgColor }
    @objc dynamic public class var calendarCellBorderColor: UIColor { return Cache.calendarCellBorderColor }
    @objc dynamic public class var calendarCellTitleColor: UIColor { return Cache.calendarCellTitleColor }
    @objc dynamic public class var calendarCellDateColor: UIColor { return Cache.calendarCellDateColor }
    @objc dynamic public class var loginViewBorderColor: UIColor { return Cache.loginViewBorderColor }

    //// Gradients

    @objc dynamic public class var mainGradient: CGGradient { return Cache.mainGradient }

    //// Drawing Methods

    @objc dynamic public class func drawCanvas1(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 240, height: 120), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 240, height: 120), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 240, y: resizedFrame.height / 120)
        
        context.restoreGState()

    }




    @objc(SharedStyleKitResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
