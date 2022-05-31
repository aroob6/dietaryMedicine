//
//  UIScrollView.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/31.
//

import UIKit

public enum ScrollDirection {
    case info
    case analysis
    case buyInfo
}

public extension UIScrollView {
    func scroll(to direction: ScrollDirection) {
        DispatchQueue.main.async {
            switch direction {
            case .info:
                self.scrollToInfo()
            case .analysis:
                self.scrollToAnalysis()
            case .buyInfo:
                self.scrollToBuyInfo()
            }
        }
    }

    private func scrollToInfo() {
        //name 50 img 300 spacing 20
        let centerOffset = CGPoint(x: 0, y: 370)
        setContentOffset(centerOffset, animated: true)
    }

    private func scrollToAnalysis() {
        //name 50 img 300 spacing 20 tabbar 50 infotableView 480
        let centerOffset = CGPoint(x: 0, y: 900)
        setContentOffset(centerOffset, animated: true)
    }

    private func scrollToBuyInfo() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
