//
//  PastableTextField.swift
//  PasteHelperDemo
//
//  Created by Ahmadreza on 8/8/22.
//

import UIKit

@objc protocol PasteHelperDelegate: AnyObject {
    func isClipboardInputValidToShowPastePopup(clipboardText: String)-> Bool
    @objc optional func pastableTextFieldDidChangeSelection(_ textField: UITextField)
}

class PastableTextField: UITextField {
    
    weak var helperDelegate: PasteHelperDelegate?
    var context: LContextView?
    
    func setupPasteHelper(delegate: PasteHelperDelegate) {
        helperDelegate = delegate
        self.delegate = self
        addGesture()
    }
    
    func getClipBoardString()-> String {
        if let text = UIPasteboard.general.string {
            return text
        }
        return ""
    }
    
    func addGesture() {
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBecameActive), name: UITextField.textDidBeginEditingNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidDeactive), name: UITextField.textDidEndEditingNotification, object: self)
    }
    
    @objc func textFieldDidBecameActive() {
        if isFirstResponder {
            let newText = getClipBoardString()
            if text!.isEmpty {
                if helperDelegate?.isClipboardInputValidToShowPastePopup(clipboardText: newText) ?? false {
                    context = nil
                    context = LContextView(text: newText, superView: self)
                    context?.addAction { tappedInside in
                        if tappedInside {
                            self.text = newText
                            self.resignFirstResponder()
                        }
                    }
                }
            }
        }
    }
    
    @objc func textFieldDidDeactive() {
        context?.tapAction()
    }
}

// MARK: You can add any textField delegation here and pass it to the PasteHelperDelegate protocol
extension PastableTextField: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        helperDelegate?.pastableTextFieldDidChangeSelection?(textField)
    }
}
