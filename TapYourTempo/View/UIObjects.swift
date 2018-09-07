//
//  UIObjects.swift
//  TapYourTempo
//
//  Created by Ted Sauerbrey on 1/30/18.
//  Copyright © 2018 Ted Sauerbrey. All rights reserved.
//

import UIKit

extension UIFont {
    static let standard = "TrebuchetMS"
}

extension UIView {
    @discardableResult func anchor(topParent: UIView, topConstant: CGFloat = 0, leadingParent: UIView, leadingConstant: CGFloat = 0, trailingConstant: CGFloat = 0, trailingParent: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: topParent.topAnchor, constant: topConstant).isActive = true
        leftAnchor.constraint(equalTo: leadingParent.leftAnchor, constant: leadingConstant).isActive = true
        rightAnchor.constraint(equalTo: trailingParent.rightAnchor, constant: trailingConstant).isActive = true
        return self
    }
}

extension UIButton {
    convenience init(normalImageName: String, highlightedImageName: String) {
        let normalImage = UIImage(named: normalImageName)
        let highlightedImage = UIImage(named: highlightedImageName)
        self.init()
        setImage(normalImage, for: .normal)
        setImage(highlightedImage, for: .highlighted)
    }
    
    @discardableResult func centerUIButton(centerToView parentView: UIView, width: CGFloat, height: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult func positionUIButton(topParent: UIView, topConstant: CGFloat = 0, bottomParent: UIView, bottomConstant: CGFloat = 0, leadingParent: UIView, leadingConstant: CGFloat = 0, trailingConstant: CGFloat = 0, trailingParent: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: topParent.topAnchor, constant: topConstant).isActive = true
        bottomAnchor.constraint(equalTo: bottomParent.topAnchor, constant: bottomConstant).isActive = true
        leftAnchor.constraint(equalTo: leadingParent.leftAnchor, constant: leadingConstant).isActive = true
        rightAnchor.constraint(equalTo: trailingParent.rightAnchor, constant: trailingConstant).isActive = true
        
        return self
    }
}

extension UILabel {
    convenience init(labelText: String, fontName: String = UIFont.standard, fontSize: CGFloat = standardWidth, fontColor: UIColor = UIColor(r: 235, g: 237, b: 222), alignment: NSTextAlignment = .center) {
        self.init()
        text = labelText
        font = UIFont(name: fontName, size: fontSize)
        textColor = fontColor
        textAlignment = alignment
    }
    
    @discardableResult func centerLabelToView(parentView: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        return self
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

class UIObjects {
    
    let fontSize: CGFloat = standardWidth
    let colorCreme = UIColor(r: 235, g: 237, b: 222)
    let colorDark = UIColor(r: 44, g: 44, b: 44 )
    
    func tapButton() -> UIButton {
        let tapButton = UIButton(normalImageName: ImageNames.tapButtonNormal,
                             highlightedImageName: ImageNames.tapButtonHighlighted)
        tapButton.addTarget(nil, action: #selector(ViewController.tapButtonTapped), for: .touchDown)
        return tapButton
    }
    
    func tapHereLabel() -> UILabel {
        let tapHereLabel = UILabel(labelText: Strings.tapHereLabelText, fontSize: fontSize, fontColor: colorDark)
        tapHereLabel.numberOfLines = 2
        
        return tapHereLabel
    }
    
    func tempoLabel(text: String) -> UILabel {
        let tempoLabel = UILabel(labelText: text, fontSize: fontSize*2.5)
        // update font size and color if there is a BPM number to display
        if text.count == 0 || text.count > 3 {
            tempoLabel.font = UIFont(name: UIFont.standard, size: fontSize*1.5)
        }
        else {
            let amountText: NSMutableAttributedString = NSMutableAttributedString.init(string:text + " BPM")
            amountText.setAttributes([NSAttributedStringKey.font: UIFont(name: UIFont.standard, size: fontSize)!,
                                      NSAttributedStringKey.foregroundColor: colorCreme],
                                     range: NSMakeRange(text.count+1, 3))
            tempoLabel.attributedText = amountText
        }

        return tempoLabel
    }
    
    func resetButton() -> UIButton {
        let resetButton = UIButton(normalImageName: ImageNames.resetButtonNormal, highlightedImageName: ImageNames.resetButtonHighlighted)
        resetButton.addTarget(nil, action: #selector(ViewController.resetButtonTapped), for: .touchUpInside)
        resetButton.frame = CGRect(x: screenWidth*0.2 - standardWidth*2, y: screenHeight*0.75, width: standardWidth*4, height: standardWidth*4)
        return resetButton
    }
    
    func soundOnOffButton(soundOn: Bool) -> UIButton {
        let imageNames = soundButtonImageNames(soundOn: soundOn)
        let soundOOButton = UIButton(normalImageName: imageNames.0, highlightedImageName: imageNames.1)
        soundOOButton.frame = CGRect(x: screenWidth*0.8 - standardWidth*2, y: screenHeight*0.75, width: standardWidth*4, height: standardWidth*4)
        soundOOButton.tag = 100
        soundOOButton.addTarget(self, action: #selector(ViewController.soundButtonTapped), for: .touchUpInside)
        
        return soundOOButton
    }
    
    func soundButtonImageNames(soundOn: Bool) -> (String, String) {
        if soundOn {return ImageNames.soundOnNames}
        else {return ImageNames.soundOffNames}
    }
    
    func optionsButton() -> UIButton {
        let optionsButton = UIButton(normalImageName: ImageNames.optionsButtonNormal, highlightedImageName: ImageNames.optionsButtonHighlighted)
        optionsButton.addTarget(nil, action: #selector(ViewController.optionsButtonTapped), for: .touchUpInside)
        optionsButton.frame = CGRect(x: screenWidth/2 - standardWidth*2, y: screenHeight*0.75, width: standardWidth*4, height: standardWidth*4)
        
        return optionsButton
        
    }
    
    func optionsScreen(animate: Bool, bpmCalcOption: Int) -> UIView {
        let optionsScreen = UIView(frame: CGRect(x: 0, y: screenHeight*0.05, width: screenWidth, height: screenHeight*0.9))
        optionsScreen.backgroundColor = colorDark
        optionsScreen.layer.borderColor = colorCreme.cgColor
        optionsScreen.layer.borderWidth = 3
        optionsScreen.layer.cornerRadius = 6
        let titleLabel = UILabel(labelText: Strings.optionsScreenTitleText)
        titleLabel.frame = CGRect(x: 0, y: standardWidth/2, width: screenWidth, height: screenHeight/20)
        optionsScreen.addSubview(titleLabel)
        
        for i in 0..<3 {
            let oButtonLine = bpmButtonText(btnNum: CGFloat(i), bpmCalcOption: bpmCalcOption)
            optionsScreen.addSubview(oButtonLine.0)
            optionsScreen.addSubview(oButtonLine.1)
            oButtonLine.0.addTarget(self, action: #selector(ViewController.optionChosen(sender:)), for: UIControlEvents.touchUpInside)
        }
        
        let exitButton = exitOptionsButton()
        exitButton.addTarget(self, action: #selector(ViewController.exitOptionsButtonTapped), for: UIControlEvents.touchUpInside)
        optionsScreen.addSubview(exitButton)
        
        if animate {optionsScreen.alpha = 0
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: UIViewAnimationOptions.curveEaseIn,
                           animations: { () -> Void in
                            optionsScreen.alpha = 1
            }, completion: { (finished) -> Void in
                optionsScreen.alpha = 1
            })
        }
        
        return optionsScreen
    }
    
    func bpmButtonText(btnNum: CGFloat, bpmCalcOption: Int) -> (UIButton, UILabel) {
        let loc = CGFloat(5)*(btnNum+1)
        var normalImageName = ""
        var highlightedImageName = ""
        
        if Int(btnNum) == bpmCalcOption {
            normalImageName = ImageNames.blueButtonNormal
            highlightedImageName = ImageNames.blueButtonHighlighted
        }
        else {
            normalImageName = ImageNames.nonBlueButtonNormal
            highlightedImageName = ImageNames.nonBlueButtonHighlighted
        }
        let bpmButton = UIButton(normalImageName: normalImageName, highlightedImageName: highlightedImageName)
        bpmButton.frame = CGRect(x: screenWidth/4, y: standardWidth*loc, width: standardWidth*2, height: standardWidth*2)
        bpmButton.tag = Int(btnNum)
        let bpmLabel = UILabel(labelText: Strings.bpmLabelNames[Int(btnNum)])
        bpmLabel.frame = CGRect(x: screenWidth/2, y: standardWidth*loc, width: screenWidth/4, height: standardWidth*2)
        bpmLabel.textAlignment = .natural

        return (bpmButton, bpmLabel)
    }
    
    func exitOptionsButton() -> UIButton {
        let exitButton = UIButton(frame: CGRect(x: standardWidth, y: standardWidth, width: standardWidth*2, height: standardWidth*2))
        exitButton.setImage(UIImage(named: ImageNames.exitButtonNormal), for: .normal)
        exitButton.setImage(UIImage(named: ImageNames.exitButtonHighlighted), for: .highlighted)
        
        return exitButton
    }
    
}
