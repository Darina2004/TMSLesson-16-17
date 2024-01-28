//
//  GestureManager.swift
//  TMSLesson16
//
//  Created by Mac on 19.01.24.
//

import UIKit

protocol GestureManagerDelegate: AnyObject {
    func circleTapped()
    func handlePan(_ gesture: UIPanGestureRecognizer)
}

class GestureManager {
    private let circleView: UIView
    weak var delegate: GestureManagerDelegate?
    
    init(circleView: UIView) {
        self.circleView = circleView
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(circleTapped))
        circleView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        circleView.addGestureRecognizer(panGesture)
    }
    
    @objc private func circleTapped() {
        delegate?.circleTapped()
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        delegate?.handlePan(gesture)
    }
}
