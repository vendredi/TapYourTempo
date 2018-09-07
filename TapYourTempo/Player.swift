//
//  Sound.swift
//  TapYourTempo
//
//  Created by Ted Sauerbrey on 2/4/18.
//  Copyright © 2018 Ted Sauerbrey. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

var soundIsOn = true

class Player {
    
    // Variables
    var audioFile: AVAudioPlayer!
    
    // Initializer
    init() {
        // Set path for the attack sound
        
        let audioSnd = Bundle.mainBundle().pathForResource("test", ofType: "wav")
        let audioFileURL = NSURL(fileURLWithPath: audioSnd!)
        
        do {
            
            try audioFile = AVAudioPlayer(contentsOfURL: audioFileURL, fileTypeHint: nil)
            audioFile.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    // Methods
    func playAudioFile() {
        
        if audioFile.isPlaying {
            audioFile.stop()
        } else {
            audioFile.play()
        }
    }
}
