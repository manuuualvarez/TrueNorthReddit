//
//  UIApplication+Extension.swift
//  TrueNothReddit
//
//  Created by Manuel Alvarez on 1/20/22.
//

import Foundation
import UIKit

extension UIApplication {
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}
