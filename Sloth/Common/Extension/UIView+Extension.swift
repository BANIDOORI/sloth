//
//  UIView+Extension.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

extension UIView {
    func applyZigZagEffect(givenView: UIView) {
        let width = givenView.frame.size.width
        let height = givenView.frame.size.height
        
        let givenFrame = givenView.frame
        let zigZagWidth = CGFloat(7)
        let zigZagHeight = CGFloat(5)
        var yInitial = height-zigZagHeight
        
        let zigZagPath = UIBezierPath(rect: givenFrame)
        zigZagPath.move(to: CGPoint(x:0, y:0))
        zigZagPath.addLine(to: CGPoint(x:0, y:yInitial))
        
        var slope = -1
        var x = CGFloat(0)
        var i = 0
        while x < width {
            x = zigZagWidth * CGFloat(i)
            let p = zigZagHeight * CGFloat(slope)
            let y = yInitial + p
            let point = CGPoint(x: x, y: y)
            zigZagPath.addLine(to: point)
            slope = slope*(-1)
            i += 1
        }
        
        zigZagPath.addLine(to: CGPoint(x:width,y: 0))
        
        yInitial = 0 + zigZagHeight
        x = CGFloat(width)
        i = 0
        while x > 0 {
            x = width - (zigZagWidth * CGFloat(i))
            let p = zigZagHeight * CGFloat(slope)
            let y = yInitial + p
            let point = CGPoint(x: x, y: y)
            zigZagPath.addLine(to: point)
            slope = slope*(-1)
            i += 1
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = zigZagPath.cgPath
        givenView.layer.mask = shapeLayer
    }
}
