//
//  AndesTagViewConfigFactory.swift
//  AndesUI
//
//  Created by Samuel Sainz on 5/28/20.
//

import Foundation

internal class AndesTagViewConfigFactory {

    static func provideInternalConfig(fromSimpleTag tag: AndesTagSimple) -> AndesTagViewConfig {

        let type = AndesTagTypeFactory.provide(tag.type)
        let size = AndesTagSizeFactory.provide(tag.size)

        let backgroundColor = type.backgroundColor
        let borderColor = type.borderColor
        let buttonColor = type.buttonColor

        let height = size.height
        let horizontalPadding = size.horizontalPadding
        let cornerRadius = size.cornerRadius

        let text = tag.text
        let textFont = size.font
        let textColor = type.textColor

        let leftContent = size.shouldShowLeftContent ? tag.leftContent : nil
        let rightButtonWidth = tag.isDismissible ? size.rightButtonWidth : 0
        let rightButtonImageName = tag.isDismissible ? AndesIcons.close16 : nil

        return AndesTagViewConfig(backgroundColor: backgroundColor, borderColor: borderColor, buttonColor: buttonColor, height: height, horizontalPadding: horizontalPadding, cornerRadius: cornerRadius, text: text, textFont: textFont, textColor: textColor, leftContent: leftContent, rightButtonImageName: rightButtonImageName, rightButtonWidth: rightButtonWidth)
    }

    static func provideInternalConfig(fromChoiceTag tag: AndesTagChoice) -> AndesTagViewConfig {

        let state = AndesTagStateFactory.provide(tag.state)
        let size = AndesTagSizeFactory.provide(tag.size)
        let type = AndesTagChoiceTypeFactory.provide(tag.type, forState: state)

        let backgroundColor = state.backgroundColor
        let borderColor = state.borderColor
        let buttonColor = state.buttonColor

        let height = size.height
        let horizontalPadding = size.horizontalPadding
        let cornerRadius = size.cornerRadius

        let text = tag.text
        let textFont = size.font
        let textColor = state.textColor

        let leftContent = size.shouldShowLeftContent ? tag.leftContent : nil

        let rightButtonImageName = type.rightButtonImageName

        let rightButtonWidth: CGFloat = rightButtonImageName != nil ? size.rightButtonWidth : 0

        let shouldAnimateRightContent: Bool = tag.shouldAnimateTag

        return AndesTagViewConfig(backgroundColor: backgroundColor, borderColor: borderColor, buttonColor: buttonColor, height: height, horizontalPadding: horizontalPadding, cornerRadius: cornerRadius, text: text, textFont: textFont, textColor: textColor, leftContent: leftContent, rightButtonImageName: rightButtonImageName, rightButtonWidth: rightButtonWidth, shouldAnimateRightContent: shouldAnimateRightContent)
    }
}
