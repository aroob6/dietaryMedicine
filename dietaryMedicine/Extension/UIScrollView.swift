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
    func scroll(to direction: ScrollDirection, y: CGFloat) {
        DispatchQueue.main.async {
            switch direction {
            case .info:
                self.scrollToInfo(y)
            case .analysis:
                self.scrollToAnalysis(y)
            case .buyInfo:
                self.scrollToBuyInfo(y)
            }
        }
    }

    private func scrollToInfo(_ y: CGFloat) { //50은 헤더 크기
        let centerOffset = CGPoint(x: 0, y: y - 50)
        setContentOffset(centerOffset, animated: true)
    }

    private func scrollToAnalysis(_ y: CGFloat) {
        let centerOffset = CGPoint(x: 0, y: y - 50)
        setContentOffset(centerOffset, animated: true)
    }

    private func scrollToBuyInfo(_ y: CGFloat) {
//        let centerOffset = CGPoint(x: 0, y: y - 50)
//        setContentOffset(centerOffset, animated: true)
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
