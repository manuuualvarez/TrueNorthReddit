//
//  UIView+Extension.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//

import Foundation
import UIKit.UIView

// MARK: - Styling

extension UIView {
    @objc func finishEditing() {
        subviews.forEach {
            if $0.isFirstResponder {
                $0.resignFirstResponder()
            } else {
                $0.finishEditing()
            }
        }
    }
}

// MARK: - Editing

extension UIView {
    func setupToEndEditingOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
}

// MARK: - Load

extension UIView {
    class func fromNib<T: UIView>(name: String? = nil) -> T {
        
        if let name = name  {
            return Bundle(for: T.self).loadNibNamed(name, owner: nil, options: nil)![0] as! T
        }else{
            return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
        }
    }
}
