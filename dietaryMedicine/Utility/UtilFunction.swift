//
//  UtilFunction.swift
//  dietaryMedicine
//
//  Created by 이보라 on 2022/05/21.
//

import UIKit

public enum CompletionCode {
    case Cancel
    case Okay
    case Retry
}

class UtilFunction {
    // MARK: - Show Error Message
    static func showMessage(
        msg: String,
        vc: UIViewController,
        completion : @escaping (CompletionCode) -> Void = {  _ in }
    ) {
        let dialog = UIAlertController(title: "안내", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { _ in
            completion(CompletionCode.Okay)
        }
        dialog.addAction(action)
        DispatchQueue.main.async {
            vc.present(dialog, animated: true)
        }
    }
    static func showDeleteMessage(
        msg: String,
        vc: UIViewController,
        completion : @escaping (CompletionCode) -> Void = {  _ in }
    ) {
        let dialog = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { _ in
            completion(CompletionCode.Okay)
        }
        dialog.addAction(cancel)
        dialog.addAction(action)
        DispatchQueue.main.async {
            vc.present(dialog, animated: true)
        }
    }
}
