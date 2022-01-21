//
//  LoaderAnimator.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//

import Foundation
import UIKit.UIView
import Lottie

protocol LoaderAnimator {
    func show(view: UIView)
    func hide()
}


final class LoaderAnimatorAdapter: LoaderAnimator {
    
    static var shared: LoaderAnimator = LoaderAnimatorAdapter()
    private var isLoaderPresented = false
    private var containerView: AnimationView?
    
    public func show(view: UIView){
        if !isLoaderPresented {
            view.isUserInteractionEnabled = false
            let background = UIView(frame: UIScreen.main.bounds)
            background.backgroundColor = .backgroundLoader
            containerView = LottieAnimationBuilder.createAnimation(contentMode: .scaleAspectFit, loopMode: .loop, animationName: "newsLoader")
            containerView?.frame.size = CGSize(width: background.frame.size.width / 2, height: background.frame.size.height / 2)
            containerView?.frame =  UIScreen.main.bounds
            background.addSubview(containerView!)
            view.addSubview(background)
            isLoaderPresented = true
            containerView?.play()
        }
    }
    
    
    public func hide(){
        if let containerView = containerView {
            containerView.stop()
            isLoaderPresented = false
            containerView.superview?.superview?.isUserInteractionEnabled = true
            containerView.superview?.removeFromSuperview()
        }
    }
}



class LottieAnimationBuilder {
    static func createAnimation(contentMode: UIView.ContentMode, loopMode: LottieLoopMode, animationName: String) -> AnimationView {
        let returnable = AnimationView()
        returnable.animation = Animation.named(animationName)
        returnable.contentMode = contentMode
        returnable.loopMode = loopMode
        return returnable
    }
}
