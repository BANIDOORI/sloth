//
//  SwitchView.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

final class SwitchView: UISwitch {
    override func layoutSubviews() {
        super.layoutSubviews()
        setThumbRatio(ratio: 0.75)
        self.transform = CGAffineTransform(translationX: 0, y: -5)
    }
    
    public func setThumbRatio(ratio: CGFloat){
        if let thumb = self.subviews[0].subviews[1].subviews[2] as? UIImageView {
            thumb.layer.anchorPoint = CGPoint(x: 0.5, y: 0.52)
            thumb.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        }
    }
}
