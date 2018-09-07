//
//  ViewController.swift
//  TapYourTempo
//
//  Created by Ted Sauerbrey on 11/29/17.
//  Copyright © 2017 Ted Sauerbrey. All rights reserved.
//

import UIKit
import AVFoundation

var screenHeight: CGFloat = 0
var screenWidth: CGFloat = 0
var standardWidth: CGFloat = 0

class ViewController: UIViewController {
    
    var tempoLabel = UILabel()
    var audioPlayer = AVAudioPlayer()
    var soundOn = false
    var bpmCalcOption = 0
    
    var tapTimeStamps: [TimeInterval] = []
    var tapButton = UIButton()
    var tapHereLabel = UILabel()
    var optionsScreen = UIView()
    
    var savedSoundOnOff = UserDefaults()
    let savedSoundOnOffConstant = "retSoundOnOff"
    var savedBPMCalcOption = UserDefaults()
    let savedBPMCalcConstant = "retBPMCalc"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        setupVariables()
        setupUserDefaults()
        setupMainScreen()
        playSound(initialize: true)
    }
    
    private func setupMainScreen() {
        setupTapButton()
        
        setupResetButton()
        setupOptionsButton()
        setupSoundOnOffButton()
        
        displayTempo(beatsPerMinute: 0)
    }

    private func setupTapButton() {
        tapButton = UIObjects().tapButton()
        self.view.addSubview(tapButton)
        tapButton.centerUIButton(centerToView: self.view, width: screenWidth/2, height: screenWidth/2)
        setupTapHereLabel()
    }
    
    private func setupTapHereLabel() {
        tapHereLabel.removeFromSuperview()
        tapHereLabel = UIObjects().tapHereLabel()
        tapButton.addSubview(tapHereLabel)
        tapHereLabel.centerLabelToView(parentView: self.view)
    }
    
    private func setupResetButton() {
        let rb = UIObjects().resetButton()
        self.view.addSubview(rb)
    }
    
    private func setupOptionsButton() {
        let ob = UIObjects().optionsButton()
        self.view.addSubview(ob)
    }
    
    private func setupSoundOnOffButton() {
        let sb = UIObjects().soundOnOffButton(soundOn: soundOn)
        self.view.addSubview(sb)
    }
    
    private func displayTempo(beatsPerMinute: Int) {
        var stringBPM = "\(beatsPerMinute)"
        if beatsPerMinute < 1 {stringBPM = Strings.calcBPM}
        tempoLabel.removeFromSuperview()
        tempoLabel = UIObjects().tempoLabel(text: stringBPM)
        self.view.addSubview(tempoLabel)
        tempoLabel.anchor(topParent: self.view, topConstant: 100, leadingParent: self.view, trailingParent: self.view)
    }
    
    @objc func tapButtonTapped() {
        if soundOn {
            playSound()
        }
        tapHereLabel.removeFromSuperview()
        
        tapTimeStamps.append(CACurrentMediaTime())
        
        switch bpmCalcOption {
        case 0:
            displayTempo(beatsPerMinute: Calculate().getTempoFromTimeRange(seconds: 2, timeStampList: tapTimeStamps))
        case 1:
            displayTempo(beatsPerMinute: Calculate().getTempoFromTimeRange(seconds: 3, timeStampList: tapTimeStamps))
        case 2:
            displayTempo(beatsPerMinute: Calculate().getTempoFromLastThreeTaps(timeStampList: tapTimeStamps))
        default:
            displayTempo(beatsPerMinute: Calculate().getTempoFromLastThreeTaps(timeStampList: tapTimeStamps))
        }
    }
    
    @objc func soundButtonTapped() {
        soundOn = !soundOn
        savedSoundOnOff.set(soundOn, forKey: savedSoundOnOffConstant)
        setupSoundOnOffButton()
    }
 
    @objc func resetButtonTapped() {
        tapTimeStamps.removeAll()
        displayTempo(beatsPerMinute: 0)
        setupTapHereLabel()
    }
    
    @objc func optionsButtonTapped() {
        // show the animation on first tap
        setupOptionsScreen(animate: true)
    }
    
    @objc func exitOptionsButtonTapped() {
        UIView.animate(withDuration: 0.3, animations: {
            self.optionsScreen.alpha = 0
            }, completion: { (finished) -> Void in
            self.optionsScreen.removeFromSuperview()
        })
    }
    
    private func setupOptionsScreen(animate: Bool = false) {
        optionsScreen.removeFromSuperview()
        optionsScreen = UIObjects().optionsScreen(animate: animate, bpmCalcOption: bpmCalcOption)
        self.view.addSubview(optionsScreen)
    }
    
    @objc func optionChosen(sender: UIButton) {
        bpmCalcOption = sender.tag
        savedBPMCalcOption.set(bpmCalcOption, forKey: savedBPMCalcConstant)
        tapTimeStamps.removeAll()
        playSound(initialize: true)
        setupOptionsScreen()
    }
    
    private func setupVariables() {
        screenHeight = self.view.frame.height
        screenWidth = self.view.frame.width
        standardWidth = screenWidth/20
    }
    
    private func setupUserDefaults() {
        soundOn = savedSoundOnOff.bool(forKey: savedSoundOnOffConstant)
        bpmCalcOption = savedBPMCalcOption.integer(forKey: savedBPMCalcConstant)
    }
}

extension ViewController: AVAudioPlayerDelegate {
    private func playSound(initialize: Bool = false) {
        guard let soundUrl = Bundle.main.url(forResource: Strings.beatSoundFileName, withExtension: "aiff")
            else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            if initialize {audioPlayer.volume = 0.01}
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch _ {
            return print("sound file not found")
        }
    }
}
