//
//  PrioritySystem.swift
//  Scheduler
//
//  Created by Vanessa Woo on 2.12.16.
//  Copyright © 2016 Omnicon Industries. All rights reserved.
//

import UIKit

class PrioritySystem: UIView {
    
    //MARK: Properties
    var priority: Int = SettingsViewController.CurrentSettings.currentSettings.defaultPriority {
        didSet {
            setNeedsLayout()
        }
    }
    var priorityButtons: [UIButton] = [UIButton]()
    var buttonImageList: [UIImage] = [UIImage]()
    
    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let unpressedLPImage = UIImage(named: "UnpressedLowPriority")
        let unpressedMPImage = UIImage(named: "UnpressedMedPriority")
        let unpressedHPImage = UIImage(named: "UnpressedHighPriority")
        let pressedLPImage = UIImage(named: "PressedLowPriority")
        let pressedMPImage = UIImage(named: "PressedMedPriority")
        let pressedHPImage = UIImage(named: "PressedHighPriority")
        self.buttonImageList = [unpressedHPImage!,unpressedMPImage!,unpressedLPImage!,pressedHPImage!,pressedMPImage!,pressedLPImage!]
        for _ in 0..<3 {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            button.addTarget(self, action: #selector(PrioritySystem.priorityButtonTapped(_:)), for: .touchDown)
            priorityButtons.append(button)
            addSubview(button)
        }
    }
    
    override var intrinsicContentSize : CGSize {
        return CGSize(width: 240, height: 44)
    }
    
    override func layoutSubviews() {
        let buttonSize: Int = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in priorityButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + 10))
            button.setImage(self.buttonImageList[index], for: UIControlState())
            button.setImage(self.buttonImageList[index+3], for: .selected)
            button.setImage(self.buttonImageList[index+3], for: [.selected, .highlighted])
            button.adjustsImageWhenHighlighted = false
            button.frame = buttonFrame
        }
    }
    
    //MARK: - Actions
    func priorityButtonTapped(_ button: UIButton) {
        priority = (3 - priorityButtons.index(of: button)!)
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in priorityButtons.enumerated() {
            if index == 3 - priority {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }
}
