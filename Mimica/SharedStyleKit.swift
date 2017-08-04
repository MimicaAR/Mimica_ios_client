//
//  SharedStyleKit.swift
//  Mimica
//
//  Created by Gleb LInnik on 05.08.17.
//  Copyright © 2017 Mimica. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//
//  This code was generated by Trial version of PaintCode, therefore cannot be used for commercial purposes.
//



import UIKit

public class SharedStyleKit : NSObject {

    //// Cache

    private struct Cache {
        static let mainGradientColor: UIColor = UIColor(red: 0.988, green: 0.376, blue: 0.212, alpha: 1.000)
        static let mainGradientColor2: UIColor = UIColor(red: 1.000, green: 0.176, blue: 0.333, alpha: 1.000)
        static let mainGradient: CGGradient = CGGradient(colorsSpace: nil, colors: [SharedStyleKit.mainGradientColor.cgColor, SharedStyleKit.mainGradientColor2.cgColor] as CFArray, locations: [0, 1])!
    }

    //// Colors

    @objc dynamic public class var mainGradientColor: UIColor { return Cache.mainGradientColor }
    @objc dynamic public class var mainGradientColor2: UIColor { return Cache.mainGradientColor2 }

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
