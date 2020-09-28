//
//  AndesTagChoice.swift
//  AndesUI
//
//  Created by Facundo Conil on 9/24/20.
//

import Foundation

@objc public class AndesTagChoice: UIView {

    internal var contentView: AndesTagView!

    /// Text shown by the Simple Tag
    @objc public var text: String? {
        didSet {
            self.updateContentView()
        }
    }

    /// Size for the Simple Tag
    @objc public var size: AndesTagSize = .small {
        didSet {
            self.updateContentView()
        }
    }

    @objc public var state: AndesTagState = .idle {
        didSet {
            self.updateContentView()
        }
    }

    @objc public var type: AndesTagChoiceType = .simple {
        didSet {
            self.updateContentView()
        }
    }

    /// Set the Simple Tag left content. Available only for large size.
    @objc public var leftContent: AndesTagLeftContent? {
        didSet {
            self.updateContentView()
        }
    }

    /// Callback invoked when dismiss button is tapped
    internal var shouldSelectTag: (() -> Bool)?

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @objc public init(text: String, size: AndesTagSize, type: AndesTagChoiceType, state: AndesTagState) {
        super.init(frame: .zero)
        self.text = text
        self.size = size
        self.type = type
        self.state = state
        setup()
    }

    @objc public init(text: String, size: AndesTagSize, type: AndesTagChoiceType, state: AndesTagState, leftContent: AndesTagLeftContent?) {
        super.init(frame: .zero)
        self.text = text
        self.size = size
        self.type = type
        self.state = state
        self.leftContent = leftContent
        setup()
    }

    /// Set dismiss callback to be invoked when dismiss button is pressed
    @objc public func setSelectTag(callback: @escaping (() -> Bool)) {
        self.shouldSelectTag = callback
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
    }

    private func drawContentView(with newView: AndesTagView) {
        self.contentView = newView
        self.contentView.delegate = self
        addSubview(contentView)
        leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    /// Check if view needs to be redrawn, and then update it. This method should be called on all modifiers that may need to change which internal view should be rendered
    private func reDrawContentViewIfNeededThenUpdate() {
        let newView = provideView()
        if Swift.type(of: newView) !== Swift.type(of: contentView) {
            contentView.removeFromSuperview()
            drawContentView(with: newView)
        }
        updateContentView()
    }

    private func updateContentView() {
        let config = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: self)
        contentView.update(withConfig: config)
    }

    /// Should return a view depending on which Badge modifier is selected
    private func provideView() -> AndesTagView {
        let config = AndesTagViewConfigFactory.provideInternalConfig(fromChoiceTag: self)

        return AndesTagView(withConfig: config)
    }
}

extension AndesTagChoice: AndesTagViewDelegate {
    func didTapDismiss() {
        // Do nothing
    }

    func didTap(view: UIView) {
        guard let callback = self.shouldSelectTag else { return }
        let result = callback()
        // TODO: Handle callback
    }
}
