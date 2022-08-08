//
//  ViewController.swift
//  PasteHelperDemo
//
//  Created by Ahmadreza on 8/5/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: PastableTextField!
    @IBAction func dismissButtobAction(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.setupPasteHelper(delegate: self)
    }
}

extension ViewController: PasteHelperDelegate {
    
    func isClipboardInputValidToShowPastePopup(clipboardText: String) -> Bool {
        // MARK: Place any condition here!
        print("clipboardText", clipboardText)
        return clipboardText.count < 25
    }
}
