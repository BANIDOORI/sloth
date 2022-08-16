//
//  HalfCircleProgressBar.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/16.
//

import UIKit

class HalfCircleProgressBar: UIView {
    
    var progressColor: CGColor = UIColor.primary400.cgColor {
        didSet {
            progressLayer.strokeColor = progressColor
        }
    }
    
    var circleColor: CGColor = UIColor.gray200.cgColor {
        didSet {
            circleLayer.strokeColor = circleColor
        }
    }
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    private var startPoint = CGFloat(Double.pi)
    private var endPoint = CGFloat(Double.pi * 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var bounds: CGRect {
        didSet {
            if bounds == .zero { return }
            createCircularPath()
        }
    }
    
    func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height), radius: frame.size.height, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 5.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = circleColor
        layer.addSublayer(circleLayer)
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 5.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = progressColor
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
