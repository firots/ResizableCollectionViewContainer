//
//  UIViewExtension.swift
//  ResizableCollectionViewContainer
//
//  Created by Firot on 8.08.2021.
//

import UIKit

extension UIView {
    func fillParent(leading: CGFloat = 0, trailing: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) {
        guard let superView = superview else {
            fatalError("Fillparent without superview.")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superView.leadingAnchor,constant: leading),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: trailing),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: bottom),
            topAnchor.constraint(equalTo: superView.topAnchor, constant: top)
        ])
    }
}

extension UIView {
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self))
            .loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
                return nil
        }
        backgroundColor = .clear
        return contentView
    }
}

