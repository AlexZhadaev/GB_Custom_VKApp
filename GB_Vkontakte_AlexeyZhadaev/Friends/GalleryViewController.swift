//
//  GalleryViewController.swift
//  GB_Vkontakte_AlexeyZhadaev
//
//  Created by Жадаев Алексей on 09.09.2020.
//  Copyright © 2020 Жадаев Алексей. All rights reserved.
//

import UIKit

enum ScreenMode {
    case full, normal
}

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    var photos = [UIImage]()
    
    var currentIndex = 0
    
    var interactiveAnimator: UIViewPropertyAnimator?
    
    var isRightDirection: Bool?
    
    var imageInitialFrame: CGRect?
    
    var imageInitialTransform: CGAffineTransform?
    
    var currentMode: ScreenMode = .normal
    
    fileprivate func setupPhoto() {
        let index = currentIndex
        let count = photos.count
        let photo = photos[index]
        
        if count == 0 {return}
        if count <= index {return}
        
        photoImage.image = photo
    }
    
    fileprivate func setupGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSingleTapWith(_:)))
        self.view.addGestureRecognizer(tapRecognizer)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.view.addGestureRecognizer(panRecognizer)
        
//        let panCloseRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss))
//        self.view.addGestureRecognizer(panCloseRecognizer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPhoto()
        setupGestures()
    }
    
    //MARK:- Gestures animation
    
    func isDirectionChanged(_ dx: CGFloat) -> Bool {
        
        if (self.isRightDirection == nil) {
            self.isRightDirection = (dx > 0)
            return true
        }
        
        let isRightDirection = (dx > 0)
        
        if isRightDirection != self.isRightDirection {
            self.isRightDirection = isRightDirection
            return true
        }
        return false
    }
    
    func createInteractiveAnimationForView_FadeOut(view: UIView, isRightDirection: Bool) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(
            duration: 0.5,
            curve: .easeIn,
            animations: {
                view.alpha = 0
                view.frame =
                    view.frame.offsetBy( dx: ( isRightDirection ) ? 0 + view.frame.width : 0 - view.frame.width, dy: 0)
                view.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        })
    }
    
    @objc func didSingleTapWith(_ recognizer: UITapGestureRecognizer) {
        if self.currentMode == .full {
            changeScreenMode(to: .normal)
            self.currentMode = .normal
        } else {
            changeScreenMode(to: .full)
            self.currentMode = .full
        }
    }
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
            
        case .began:
            self.imageInitialFrame = photoImage.frame
            self.imageInitialTransform = photoImage.transform
            
        case .changed:
            let translation = recognizer.translation(in: self.view)
            
            if isDirectionChanged(translation.x) {
                if (interactiveAnimator != nil) {
                    interactiveAnimator?.stopAnimation(true)
                    photoImage.frame = imageInitialFrame!
                    photoImage.transform = imageInitialTransform!
                }
                
                interactiveAnimator =
                    createInteractiveAnimationForView_FadeOut(
                        view: photoImage,
                        isRightDirection: ( translation.x > 0 )
                )
                
                interactiveAnimator?.pauseAnimation()
                
                interactiveAnimator?.addCompletion({ (_) in
                    var index = self.currentIndex
                    let count = self.photos.count
                    
                    let isRightDirection = self.isRightDirection ?? true
                    
                    if (isRightDirection == true) {
                        index = ((index - 1) + count) % count
                    } else {
                        index = (index + 1) % count
                    }
                    
                    self.photoImage.image = self.photos[index]
                    self.currentIndex = index
                    
                    self.photoImage.alpha = 0
                    self.photoImage.frame =
                        self.imageInitialFrame!.offsetBy(
                            dx: (self.isRightDirection ?? true)
                                ? 0 - self.photoImage.frame.width
                                : 0 + self.photoImage.frame.width,
                            dy: 0)
                    
                    UIViewPropertyAnimator.runningPropertyAnimator(
                        withDuration: 0.5,
                        delay: 0,
                        options: [],
                        animations: {
                            self.photoImage.alpha = 1
                            self.photoImage.frame = self.imageInitialFrame!
                            self.photoImage.transform = self.imageInitialTransform!
                            self.isRightDirection = nil
                    })
                })
            }
            interactiveAnimator?.fractionComplete = abs(translation.x) / self.photoImage.frame.width
            
            break
            
        case .ended:
            
            interactiveAnimator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            break
            
        default: return
        }
    }
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
       switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                })
            } else {
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    //MARK: - FullScreen mode
    
    func changeScreenMode(to: ScreenMode) {
        if to == .full {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.tabBarController?.tabBar.isHidden = true
            UIView.animate(withDuration: 0.25,
                           animations: {
                            self.view.backgroundColor = .black
                            
            }, completion: { completed in })
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.tabBarController?.tabBar.isHidden = false
            UIView.animate(withDuration: 0.25,
                           animations: {
                            self.view.backgroundColor = .systemBackground
            }, completion: { completed in })
        }
    }
}
