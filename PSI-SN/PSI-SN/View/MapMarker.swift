//
//  MapMarker.swift
//  PSI-SN
//
//  Created by Agus Rustandi on 05/04/18.
//  Copyright © 2018 Sample. All rights reserved.
//

import Foundation
import UIKit

class MapMarker: UIView {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bottomView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
        self.topView.makeRound(round: 5.0)
    }
}
