//
//  AlertView.swift
//  BFWControls
//
//  Created by Tom Brodhurst-Hill on 23/02/2016.
//  Copyright © 2016 BareFeetWare.
//  Free to use at your own risk, with acknowledgement to BareFeetWare.
//

import UIKit

@IBDesignable class AlertView: NibView {

    // MARK: - Structs

    struct ButtonTitle {
        static let cancel = "Cancel"
        static let ok = "OK"
    }

    // MARK: - IBOutlets

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var messageLabel: UILabel?
    @IBOutlet weak var button0: UIButton?
    @IBOutlet weak var button1: UIButton?
    @IBOutlet weak var button2: UIButton?
    @IBOutlet weak var button3: UIButton?
    @IBOutlet weak var button4: UIButton?
    @IBOutlet weak var button5: UIButton?
    @IBOutlet weak var button6: UIButton?
    @IBOutlet weak var button7: UIButton?

    @IBOutlet var horizontalButtonsLayoutConstraints: [NSLayoutConstraint]?
    @IBOutlet var verticalButtonsLayoutConstraints: [NSLayoutConstraint]?
    
    // MARK: - Variables

    @IBInspectable var title: String? {
        didSet {
            titleLabel?.text = title
        }
    }
    
    @IBInspectable var message: String? {
        didSet {
            messageLabel?.text = message
        }
    }
    
    @IBInspectable var hasCancel: Bool = true {
        didSet {
            setNeedsUpdateView()
        }
    }
    
    @IBInspectable var button0Title: String? {
        didSet {
            setNeedsUpdateView()
        }
    }

    @IBInspectable var button1Title: String? {
        didSet {
            button1?.setTitle(button1Title, forState: .Normal)
            setNeedsUpdateView()
        }
    }

    @IBInspectable var button2Title: String? {
        didSet {
            button2?.setTitle(button2Title, forState: .Normal)
            setNeedsUpdateView()
        }
    }

    @IBInspectable var button3Title: String? {
        didSet {
            button3?.setTitle(button3Title, forState: .Normal)
            setNeedsUpdateView()
        }
    }
    
    @IBInspectable var button4Title: String? {
        didSet {
            button4?.setTitle(button4Title, forState: .Normal)
            setNeedsUpdateView()
        }
    }
    
    @IBInspectable var button5Title: String? {
        didSet {
            button5?.setTitle(button5Title, forState: .Normal)
            setNeedsUpdateView()
        }
    }
    
    @IBInspectable var button6Title: String? {
        didSet {
            button6?.setTitle(button6Title, forState: .Normal)
            setNeedsUpdateView()
        }
    }
    
    @IBInspectable var button7Title: String? {
        didSet {
            button7?.setTitle(button7Title, forState: .Normal)
            setNeedsUpdateView()
        }
    }
    
    @IBInspectable var maxHorizontalButtonTitleCharacterCount: Int = 9 {
        didSet {
            setNeedsUpdateView()
        }
    }
    
    // MARK: - Functions
    
    func buttonTitleAtIndex(index: Int) -> String? {
        let button = buttons[index]
        return button.currentTitle
    }
    
    func indexOfButton(button: UIButton) -> Int? {
        return buttons.indexOf(button)
    }
    
    // MARK: - Private variables and functions

    private var buttons: [UIButton] {
        return [button0, button1, button2, button3, button4, button5, button6, button7].flatMap { $0 }
    }
    
    private var displayedButton0Title: String {
        return button0Title ?? (hasCancel ? ButtonTitle.cancel : ButtonTitle.ok)
    }
    
    private var isHorizontalLayout: Bool {
        var isHorizontalLayout = false
        // TODO: Check all titles.
        if button2Title == nil && button3Title == nil {
            if let button1Title = button1Title
                // TODO: Use total width of characters instead of count.
                where displayedButton0Title.characters.count <= maxHorizontalButtonTitleCharacterCount
                    && button1Title.characters.count <= maxHorizontalButtonTitleCharacterCount
            {
                isHorizontalLayout = true
            }
        }
        return isHorizontalLayout
    }
    
    private func hideUnused() {
        let forwardButtons = buttons.filter { $0 != button0 }
        for button in forwardButtons {
            let title = button.titleForState(.Normal)
            button.hidden = title == nil || isPlaceholderString(title)
        }
        messageLabel?.activateOnlyConstraintsWithFirstVisibleInViews(buttons.reverse())
        if let horizontalButtonsLayoutConstraints = horizontalButtonsLayoutConstraints,
            let verticalButtonsLayoutConstraints = verticalButtonsLayoutConstraints {
            if isHorizontalLayout {
                NSLayoutConstraint.activateConstraints(horizontalButtonsLayoutConstraints)
                NSLayoutConstraint.deactivateConstraints(verticalButtonsLayoutConstraints)
            } else {
                NSLayoutConstraint.activateConstraints(verticalButtonsLayoutConstraints)
                NSLayoutConstraint.deactivateConstraints(horizontalButtonsLayoutConstraints)
            }
        }
    }
    
    // MARK: - UIView
    
    // Override NibView which copies size from xib. Forces calculation using contents.
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: UIViewNoIntrinsicMetric)
    }
    
    // MARK: - NibView
    
    override var placeholderViews: [UIView]? {
        return [titleLabel, messageLabel].flatMap { $0 }
    }
    
    override func updateView() {
        super.updateView()
        button0?.setTitle(displayedButton0Title, forState: .Normal)
        hideUnused()
    }
    
}