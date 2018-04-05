//
//  ExtensionClass.swift
//  PSI-SN
//
//  Created by Agus Rustandi on 01/04/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import UIKit
import M13ProgressSuite

//    MARK: UIView extension
extension UIView {
    /**
     Rounded view with side selection
     - Parameter corners: side corners
     - Parameter size: round size
     */
    func makeRound(corners: UIRectCorner, size: CGSize) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: (corners), cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.bounds = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    /**
     Remove all customized masks
     */
    func removeMask() {
        layer.mask = nil
    }
    
    /**
     Rounded view for all corner
     - Parameter round: round size
     */
    func makeRound(round: CGFloat = 0) {
        layer.masksToBounds = true
        layer.cornerRadius = round
    }
    
    /**
     Add border to edge
     - Parameter edge: edge of side
     - Parameter color: border color
     - Parameter height: border size
     */
    func addBorderToEdge(edge: UIRectEdge, color: UIColor, height: CGFloat) {
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: height)
            break
        case .bottom:
            border.frame = CGRect.init(x: 0, y: self.frame.size.height - height, width: self.frame.size.width, height: height)
            break
        case .left:
            border.frame = CGRect.init(x: 0, y: 0, width: height, height: self.frame.size.height)
            break
        case .right:
            border.frame = CGRect.init(x: self.frame.size.height - height, y: 0, width: height, height: self.frame.size.height)
            break
        default:
            layer.borderWidth = height
            layer.borderColor = color.cgColor
            break
        }
        
        border.backgroundColor = color.cgColor
        layer.addSublayer(border)
    }
    
    /**
     Add dashed border
     - Parameter color: border color
     - Parameter height: border size
     */
    func addDashedBorder(color: UIColor, height: CGFloat){
        let shapeLayer = CAShapeLayer()
        
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = height
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [6, 3]
        shapeLayer.frame = bounds
        shapeLayer.path = UIBezierPath(rect: bounds).cgPath
        shapeLayer.borderWidth = height
        layer.addSublayer(shapeLayer)
    }
}

//    MARK: Enum extension
public protocol EnumCollection: Hashable {
    static func cases() -> AnySequence<Self>
    static var allValues: [Self] { get }
}

public extension EnumCollection {
    /**
     Get all enum components
     */
    public static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    /**
     Fetch all enum components into array
     */
    public static var allValues: [Self] {
        return Array(self.cases())
    }
}

class DateCustomization: NSObject{
    func createDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
    
    func dateToString(date: Date, format: String) -> String{
        let formatter = self.createDateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func stringToDate(string: String, format: String) -> Date{
        let formatter = self.createDateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: string)!
    }
}

//    MARK: HUD
class HUD : NSObject{
    var hud = M13ProgressHUD()
    var ring = M13ProgressViewRing()
    
    static let sharedInstance: HUD = {
        let hud = HUD.init()
        hud.ring = M13ProgressViewRing.init()
        hud.ring.showPercentage = false
        hud.ring.indeterminate = true
        hud.ring.perform(M13ProgressViewActionNone, animated: false)
        hud.hud = M13ProgressHUD.init(progressView: hud.ring)
        hud.hud.progressViewSize = CGSize(width: 60.0, height: 60.0)
        hud.hud.animationCentered = true
        hud.hud.applyBlurToBackground = true
        hud.hud.orientation = .portrait
        let screen = UIScreen.main
        hud.hud.animationPoint = CGPoint(x: screen.bounds.width/2, y: screen.bounds.height/2)
        
        let window = (UIApplication.shared.delegate as! AppDelegate).window
        window?.addSubview(hud.hud)
        
        return hud
    }()
    
    func showHUD() {
        self.hud.show(true)
    }
    
    func dismissWithMessage(msg: String) {
        self.ring.perform(msg == "" ? M13ProgressViewActionSuccess : M13ProgressViewActionFailure, animated: true)
        //        self.hud.status = msg
        self.perform(#selector(setComplete), with: nil, afterDelay: 2)
    }
    
    @objc func setComplete() {
        self.ring.perform(M13ProgressViewActionNone, animated: true)
        self.hud.hide(true)
    }
}
