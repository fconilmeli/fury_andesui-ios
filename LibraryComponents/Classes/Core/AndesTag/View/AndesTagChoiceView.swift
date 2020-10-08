//
//  AndesTagChoiceView.swift
//  AndesUI
//
//  Created by Facundo Conil on 10/6/20.
//

import Foundation

class AndesTagChoiceView: AndesTagSimpleView {

    override func updateView() {
        super.updateView()
        self.rightButton.isUserInteractionEnabled = false
    }

    override func setupRightContent() {
        super.setupRightContent()
        self.rightButton.isAccessibilityElement = false
        if config.shouldAnimateRightContent {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
}
