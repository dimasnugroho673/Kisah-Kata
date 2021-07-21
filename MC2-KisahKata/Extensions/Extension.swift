//
//  Extention.swift
//  MC2-KisahKata
//
//  Created by Dimas Putro on 24/06/21.
//

import UIKit
import AVFoundation

extension String {

    // filter string
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
        return self.filter {okayChars.contains($0) }
    }
}


extension UIImage {
    
    // untuk rounded uiimage custom
//    var roundedImage: UIImage {
//        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
//        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
//        UIBezierPath(
//            roundedRect: rect,
//            cornerRadius: 102
//            ).addClip()
//        self.draw(in: rect)
//        return UIGraphicsGetImageFromCurrentImageContext()!
//    }
}


extension UIView {
    
    // untuk rounded uiview custom
    // default value rounded 24
    func roundedBorder(cornerRadius: Int = 24) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight, .topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath.cgPath
        layer.mask = maskLayer1
    }
}


extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
