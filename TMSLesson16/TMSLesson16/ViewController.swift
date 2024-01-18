//
//  ViewController.swift
//  TMSLesson16
//
//  Created by Mac on 18.01.24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ButtonUP: UIButton!
    
    @IBOutlet weak var ButtonLeft: UIButton!
    
    @IBOutlet weak var ButtonDown: UIButton!
    
    @IBOutlet weak var ButtonRight: UIButton!
    
    let moveDistance: CGFloat = 10.0
    let buttonPadding: CGFloat = 160
    let gradientLayer = CAGradientLayer()
    
    var circleView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCircleView()
        setupGestureRecognizers()
        
    }
    
    
    @IBAction func MoveUp(_ sender: Any) {
        moveCircleUp()
    }
    
    
    @IBAction func MoveDown(_ sender: Any) {
        moveCircleDown()
        
    }
    
    @IBAction func MoveLeft(_ sender: Any) {
        moveCircleLeft()
    }
    
    @IBAction func MoveRight(_ sender: Any) {
        moveCircleRight()
    }
    
    
    func createCircleView() {
        let circleSize: CGFloat = 150
        let centerX = view.bounds.midX - circleSize / 2
        let centerY = view.bounds.midY - circleSize / 2
        
        circleView = UIView(frame: CGRect(x: centerX, y: centerY, width: circleSize, height: circleSize))
        circleView.backgroundColor = UIColor.green
        circleView.layer.cornerRadius = circleSize / 2
        view.addSubview(circleView)
    }
    
    
    func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(circleTapped))
        view.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        circleView.addGestureRecognizer(panGesture)
    }
    
    
    func springAnimation() {
        UIView.animate(withDuration: 1.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 0.0,
                       options: [],
                       animations: {
            self.circleView.center = CGPoint(x: self.view.center.x, y: 300)
        }, completion: nil)
        
    }
    
    func scaleAnimation() {
        UIView.animate(withDuration: 2.0) {
            self.circleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
    }
    
    
    func spinAnimation() {
        UIView.animate(withDuration: 1.0, animations: {
            self.circleView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, animations: {
                self.circleView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)
            })
        })
    }
    
    func rotateAnimation() {
        UIView.animate(withDuration: 2.0, animations: {
            self.circleView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            UIView.animate(withDuration: 2.0, animations: {
                self.circleView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        })
    }
    
    
    func colorAnimation() {
        UIView.animate(withDuration: 2.0) {
            self.circleView.backgroundColor = UIColor.blue
        }
    }
    
    
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        circleView.center = CGPoint(x: circleView.center.x + translation.x, y: circleView.center.y + translation.y)
        gesture.setTranslation(CGPoint.zero, in: view)
    }
    
    
    @objc func circleTapped() {
        
        let circleSize: CGFloat = 150
        let randomX = CGFloat.random(in: 0...(view.bounds.width - circleSize))
        let randomY = CGFloat.random(in: 0...(view.bounds.height - circleSize))
        UIView.animate(withDuration: 0.3) {
            self.circleView.frame = CGRect(x: randomX, y: randomY, width: circleSize, height: circleSize)
            self.circleView.backgroundColor = .random()
        }
    }
    
    @objc func moveCircleUp() {
        springAnimation()
        let newPosY = circleView.frame.origin.y - moveDistance
        if newPosY >= buttonPadding {
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame.origin.y = newPosY
            }
        }
    }
    
    
    @objc func moveCircleRight() {
        scaleAnimation()
        if circleView.frame.origin.x + circleView.frame.size.width + moveDistance <= view.bounds.width {
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame.origin.x += self.moveDistance
            }
        }
        
    }
    
    @objc func moveCircleLeft() {
        rotateAnimation()
        if circleView.frame.origin.x - moveDistance >= 0 {
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame.origin.x -= self.moveDistance
            }
        }
    }
    
    
    @objc func moveCircleDown() {
        colorAnimation()
        if circleView.frame.origin.y + circleView.frame.size.height + moveDistance <= view.bounds.height {
            UIView.animate(withDuration: 0.3) {
                self.circleView.frame.origin.y += self.moveDistance
            }
        }
    }
    
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
}
