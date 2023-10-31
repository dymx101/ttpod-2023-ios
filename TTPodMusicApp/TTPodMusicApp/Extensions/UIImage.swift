//
//  UIImage.swift
//  TTPodMusicApp
//
//  Created by XING ZHAO on 2023-10-23.
//

import UIKit

extension UIImage {
    func blur(_ radius: Double) -> UIImage? {
        if let takenImage = CIImage(image: self) {
            return UIImage(ciImage: takenImage.applyingGaussianBlur(sigma: radius))
        }
        return nil
    }
}
