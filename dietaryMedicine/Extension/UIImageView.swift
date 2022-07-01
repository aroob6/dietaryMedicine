//
//  UIImageView.swift
//  dietaryMedicine
//
//  Created by bora on 2022/07/01.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func kingFisherSetImage(url: URL) {
        self.kf.setImage(
            with: url,
            options: [
                .transition(ImageTransition.fade(0.3)),
                .keepCurrentImageWhileLoading
            ]
        )
    }
    func kingFisherSetImage(url: URL, processor: ImageProcessor) {
        self.kf.setImage(
            with: url,
            options: [
                .transition(ImageTransition.fade(0.3)),
                .keepCurrentImageWhileLoading,
                .processor(processor)
            ]
        )
    }
}
