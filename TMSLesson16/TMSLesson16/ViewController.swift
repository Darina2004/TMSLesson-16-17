//
//  ViewController.swift
//  TMSLesson16
//
//  Created by Mac on 18.01.24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonUP: UIButton!
    
    @IBOutlet weak var buttonDown: UIButton!
    
    @IBOutlet weak var buttonRight: UIButton!
    
    @IBOutlet weak var buttonLeft: UIButton!
    
    
    private let moveDistance: CGFloat = 10.0
    private let buttonPadding: CGFloat = 160
    private let gradientLayer = CAGradientLayer()
    
    private var circleView: UIView!
    private var animationManager: AnimationManager!
    private var gestureManager: GestureManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCircleView()
        setupAnimationManager()
        setupGestureManager()
    }
    
    
    @IBAction func MoveUp(_ sender: Any) {
        animationManager.moveCircleUp()
    }
    
    @IBAction func MoveDown(_ sender: Any) {
        animationManager.moveCircleDown()
    }
    
    @IBAction func MoveLeft(_ sender: Any) {
        animationManager.moveCircleLeft()
    }
    
    @IBAction func MoveRight(_ sender: Any) {
        animationManager.moveCircleRight()
    }
    
    private func setupAnimationManager() {
        animationManager = AnimationManager(circleView: circleView, moveDistance: moveDistance, buttonPadding: buttonPadding)
        
    }
    
    private func setupGestureManager() {
        gestureManager = GestureManager(circleView: circleView)
        gestureManager.delegate = self
    }
    
    private func createCircleView() {
        let circleSize: CGFloat = 150
        let centerX = view.bounds.midX - circleSize / 2
        let startY = -circleSize
        let endY = view.bounds.midY - circleSize / 2
        
        circleView = UIView(frame: CGRect(x: centerX, y: startY, width: circleSize, height: circleSize))
        circleView.backgroundColor = UIColor.green
        circleView.layer.cornerRadius = circleSize / 2
        circleView.layer.masksToBounds = true
        view.addSubview(circleView)
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [],
                       animations: {
            self.circleView.frame = CGRect(x: centerX, y: endY, width: circleSize, height: circleSize)
            self.circleView.alpha = 1.0
        },completion: nil)
        animationWithGradientLayer()
    }
    
    private func animationWithGradientLayer(){
        gradientLayer.frame = circleView.bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        circleView.layer.addSublayer(gradientLayer)
    }
    
}

extension ViewController: GestureManagerDelegate {
    func circleTapped() {
        let circleSize: CGFloat = 150
        let randomX = CGFloat.random(in: 0...(view.bounds.width - circleSize))
        let maxY = view.bounds.height - circleSize - buttonPadding
        var randomY = CGFloat.random(in: 0...maxY)
        
        if randomY < buttonPadding {
            randomY = buttonPadding
        }
        
        UIView.animate(withDuration: 0.3) {
            self.circleView.frame = CGRect(x: randomX, y: randomY, width: circleSize, height: circleSize)
            self.circleView.backgroundColor = .random()
            self.gradientLayer.removeFromSuperlayer()
        }
    }
    
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        circleView.center = CGPoint(x: circleView.center.x + translation.x, y: circleView.center.y + translation.y)
        gesture.setTranslation(CGPoint.zero, in: view)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}
