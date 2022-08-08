//
//  LContextView.swift
//  PasteHelperDemo
//
//  Created by Ahmadreza on 8/5/22.
//

import UIKit

import UIKit

class LContextView: UIView {
    
    var text: String
    var size: CGSize
    var tapComple: ((Bool)->())? = nil
    private let tagNumber = 83735353738
    private let iconWidth:CGFloat = 20
    private let iconWidthMargin:CGFloat = 16
    private var textWidth:CGFloat = 0
    private var label = UILabel()
    private var iconImageView = UIImageView()

    init(text: String, superView: UIView) {
        self.text = text
        textWidth = CGFloat(text.count * 10)
        let size = CGSize(width: iconWidthMargin + iconWidth + textWidth, height: 40)
        self.size = size
        super.init(frame: superView.frame)
        self.frame = superView.frame
        configView(superView: superView, size: size)
        semanticContentAttribute = .forceLeftToRight
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LContextView: UIGestureRecognizerDelegate {
    
    private func configView(superView: UIView, size: CGSize) {
        removePreviusContexes(superView: superView)
        superView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: -50).isActive = true
        backgroundColor = .systemBackground
        dropShadowAndCornerRadious(.large)
        addIcon()
        addText(size: size)
        addTapGesture()
        appearAnimation()
        tag = tagNumber
    }
    
    func addIcon() {
        iconImageView = UIImageView(frame: bounds)
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: iconWidth).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: iconWidth).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.image = UIImage(named: "icons8-paste")
        iconImageView.tintColor = .gray
    }
    
    private func addText(size: CGSize) {
        label = UILabel(frame: bounds)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: textWidth).isActive = true
        label.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        label.leadingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: 2).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.text = text
        label.textAlignment = .center
        label.minimumScaleFactor = 0.4
        label.textColor = .darkGray
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
    func addAction(tappedInside: ((Bool)->())?) {
        tapComple = tappedInside
    }
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tap.cancelsTouchesInView = true
        tap.delegate = self
        window?.addGestureRecognizer(tap)
    }
    
    private func removeTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        window?.removeGestureRecognizer(tap)
    }
    
    @objc func tapAction() {
        disappearAnimation()
    }
    
    private func disappearAnimation() {
        removeTapGesture()
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: .allowUserInteraction) {
            self.transform = CGAffineTransform(scaleX: 0.001, y: 0.001).translatedBy(x: 1, y: -100)
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
    
    private func appearAnimation() {
        transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.curveEaseInOut, .allowUserInteraction]) {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { _ in }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        for i in 0..<subviews.count {
            if subviews.compactMap({$0.frame.contains(touch.location(in: subviews[i]))}).contains(true) {
                tapComple?(true)
            }
        }
        tapComple?(false)
        return true
    }
    
    private func removePreviusContexes(superView: UIView) {
        if let subViews = superView.window?.allSubViews {
            for item in subViews {
                if item.tag == tagNumber {
                    if let item = item as? LContextView {
                        item.disappearAnimation()
                    }
                }
            }
        }
    }
}
