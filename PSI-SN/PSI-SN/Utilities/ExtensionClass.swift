//
//  ExtensionClass.swift
//  PSI-SN
//
//  Created by Agus Rustandi on 01/04/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import UIKit

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
