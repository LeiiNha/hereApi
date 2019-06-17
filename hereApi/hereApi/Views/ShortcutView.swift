//
//  ShortcutView.swift
//  hereApi
//
//  Created by Erica Geraldes on 15/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation
import UIKit

class ShortcutView: UIView {
    
    enum ShortcutType: Int {
        case restaurant
        case phamarcy
        case grocery
        case hotel      
    }
    
    init(type: ShortcutType, frame: CGRect) {
        super.init(frame: frame)
        if type.rawValue.isEven {
            self.backgroundColor = Colors.secondary.withAlphaComponent(0.4)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
