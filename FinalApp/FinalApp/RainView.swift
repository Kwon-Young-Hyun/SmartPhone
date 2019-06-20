//
//  RainView.swift
//  FinalApp
//
//  Created by KPUGAME on 20/06/2019.
//  Copyright © 2019 KwonYoungHyun. All rights reserved.
//

import UIKit

class RainView: UIView {

    private var emitter: CAEmitterLayer!
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(frame: ")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x:self.bounds.size.width / 2, y:self.bounds.size.height / 2)
        emitter.emitterSize = self.bounds.size
        emitter.renderMode = CAEmitterLayerRenderMode.oldestLast
        emitter.emitterShape = CAEmitterLayerEmitterShape.rectangle
        emitter.setAffineTransform(CGAffineTransform(rotationAngle: .pi / 2))
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        
        let texture: UIImage? = UIImage(named: "stamp2.png")
        assert(texture != nil, "particle image not found")
        let emitterCell = CAEmitterCell()
        
        emitterCell.name = "cell"
        emitterCell.contents = texture?.cgImage
        emitterCell.birthRate = 3
        emitterCell.lifetime = 10.0
        
        //emitterCell.xAcceleration = 100
        //emitterCell.yAcceleration = 100
        emitterCell.velocity = 100
 
        //emitterCell.velocityRange = 40
        emitterCell.scaleRange = 1
        emitterCell.scaleSpeed = -0.1
        emitterCell.emissionRange = CGFloat(0.5)
        emitterCell.spin = 2
        //emitterCell.spinRange = 3
        emitter.emitterCells = [emitterCell]
        
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {self.removeFromSuperview()})
    }

}
