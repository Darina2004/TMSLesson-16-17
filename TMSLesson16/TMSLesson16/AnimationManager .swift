//
//  AnimationManager .swift
//  TMSLesson16
//
//  Created by Mac on 19.01.24.
//

import UIKit

class AnimationManager {
    
    private let circleView: UIView
    private let moveDistance: CGFloat
    private let buttonPadding: CGFloat
    
    init(circleView: UIView, moveDistance: CGFloat, buttonPadding: CGFloat) {
        self.circleView = circleView
        self.moveDistance = moveDistance
        self.buttonPadding = buttonPadding
    }
    
    func moveCircleUp() {
        springAnimation()
        if circleView.frame.origin.y - moveDistance >= buttonPadding{
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame.origin.y = self.circleView.frame.origin.y - self.moveDistance
            }
        }
    }
    
    func moveCircleDown() {
        spinAnimation()
        if circleView.frame.origin.y + circleView.frame.size.height + moveDistance <= UIScreen.main.bounds.size.height {
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame.origin.y += self.moveDistance
            }
        }
    }
    
    func moveCircleLeft() {
        rotateAnimation()
        if circleView.frame.origin.x - moveDistance >= 0{
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame.origin.x -= self.moveDistance
            }
        }
    }
    
    func moveCircleRight() {
        scaleAnimation()
        if circleView.frame.origin.x + circleView.frame.size.width + moveDistance <= UIScreen.main.bounds.size.width{
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame.origin.x += self.moveDistance
            }
        }
    }
    
    private func springAnimation() {
        let circleSize: CGFloat = 150
        let centerX = self.circleView.center.x - circleSize / 2
        UIView.animate(withDuration: 1.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 0.0,
                       options: [],
                       animations: { [self] in
            self.circleView.frame = CGRect (x: centerX, y: self.buttonPadding, width: circleSize, height: circleSize)
        }, completion: nil)
    }
    
    private func scaleAnimation() {
        UIView.animate(withDuration: 2.0) {
            self.circleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
    }
    
    private func spinAnimation() {
        UIView.animate(withDuration: 1.0, animations: {
            self.circleView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, animations: {
                self.circleView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            })
        })
    }
    
    private func rotateAnimation() {
        UIView.animate(withDuration: 2.0) {
            self.circleView.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
}
