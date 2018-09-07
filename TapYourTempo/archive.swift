//
//  archive.swift
//  TapYourTempo
//
//  Created by Ted Sauerbrey on 1/30/18.
//  Copyright © 2018 Ted Sauerbrey. All rights reserved.
//

//import Foundation

// model

// view

// controller

//var beatsPerMinute: Int = 0


//let tempo = tapTimeStampList[tapTimeStampList.count-1] - tapTimeStampList[tapTimeStampList.count-2]
//print("new timeDiff: \(tempo)")

// find average tempo of all taps
/*
 var averageTempo: TimeInterval = 0
 for i in 0..<tapTimeStampList.count-1 {
 if i != tapTimeStampList.count {
 let time1 = tapTimeStampList[i]
 let time2 = tapTimeStampList[i + 1]
 averageTempo = (averageTempo + (time2 - time1)) / 2
 //print("averageTempo: \(averageTempo)")
 }
 }
 */


// alternatively, find the average of the last 3 taps, if 3 taps exist
/*
 if tapTimeStampList.count > 2 {
 let tapCount = tapTimeStampList.count
 let time1 = tapTimeStampList[tapCount - 3]
 let time2 = tapTimeStampList[tapCount - 2]
 let time3 = tapTimeStampList[tapCount - 1]
 let averageTempo = ((time3-time2) + (time2-time1))/2
 beatsPerMinute = Int(60 / averageTempo)
 //print("3-avg beatsPerMinuts: \(beatsPerMinute)")
 }
 
 else if tapTimeStampList.count == 2 {
 let time1 = tapTimeStampList[1]
 let time2 = tapTimeStampList[0]
 let averageTempo = time2-time1
 beatsPerMinute = Int(60 / averageTempo)
 }
 */


/*
 // find average tempo
 
 for i in 0..<tapTimeStampList.count-1 {
 if i != tapTimeStampList.count {
 let time1 = tapTimeStampList[i]
 let time2 = tapTimeStampList[i + 1]
 averageTempo = (averageTempo + (time2 - time1)) / 2
 //print("averageTempo: \(averageTempo)")
 }
 }
 
 
 // report out the tempo from the mid section
 print("tempo: \(averageTempo)")
 print("tempo returns the average of last 3")
 for i in 0..<itemsToRemove.count {
 if itemsToRemove[i] > 0 {
 print("itemsToRemove is positive")
 print("itemsToRemove at \(i): \(itemsToRemove[i])")
 if i > 0 {
 print("previous itemsToRemove: \(itemsToRemove[i-1])")
 }
 }
 }
 for i in 0..<tapCount {
 if i > 0 {
 print("difference in taps is \(tapCount - i)")
 
 }
 }
 */



/*
 <color name="colorPrimary">#3F51B5</color> (63,81,181)
 <color name="colorPrimaryDark">#303F9F</color> (48,63,159)
 <color name="colorAccent">#FF4081</color>
 <color name="chordNameMenuBackground">#2c2c2c</color> (44,44,44)
 <color name="cremeColor">#ebedde</color> (235,237,222)
 <color name="lightGrey">#a0a0a0</color> (160,160,160)
 */


// report out only the last two taps, for testing
//let tapCount = tapTimeStampList.count
//let time1 = tapTimeStampList[tapCount - 1]
//let time2 = tapTimeStampList[tapCount - 2]
//let averageTempo = time2-time1
//var averageTempo: TimeInterval = 0

/*
 // measure taps for a period of time (2 seconds)
 let currentTime = CACurrentMediaTime()
 let timeToMeasureTaps: TimeInterval = 2
 var itemsToRemove: [Int] = []
 // remove taps that occurred more than 2 seconds ago
 for i in 0..<tapTimeStampList.count {
 if tapTimeStampList[i] < currentTime - timeToMeasureTaps {
 itemsToRemove.append(i)
 }
 }
 itemsToRemove.sort(by: >)
 for i in 0..<itemsToRemove.count {
 tapTimeStampList.remove(at: itemsToRemove[i])
 }
 //print("new tapTimeStampList: \(tapTimeStampList)")
 itemsToRemove.removeAll()
 */


/*
 // for tempo by last 3 taps
 if tapTimeStampList.count > 3 {
 displayTempo(beatsPerMinute: Calculate().tempoLastThreeTaps())}
 else if tapTimeStampList.count > 0 {
 self.view.viewWithTag(50)?.removeFromSuperview()
 displayTempo(beatsPerMinute: -1)
 }
 else {
 displayTempo(beatsPerMinute: 0)
 }
 */

/*
 switch btnNum {
 case 1:
 bpmLabel.text = "2 sec"
 break
 case 2:
 bpmLabel.text = "3 sec"
 break
 case 3:
 bpmLabel.text = "last 3 taps"
 break
 default:
 bpmLabel.text = "last 3 taps"
 }
 */


/*
 for i in 0..<3 {
 let oButtonLine = UIObjects().bpmButtonText(btnNum: CGFloat(i), bpmCalcOption: bpmCalcOption)
 optionsScreen.addSubview(oButtonLine.0)
 optionsScreen.addSubview(oButtonLine.1)
 oButtonLine.0.addTarget(self, action: #selector(optionChosen(sender:)), for: UIControlEvents.touchUpInside)
 }
 
 let exitButton = UIObjects().exitOptionsButton()
 exitButton.addTarget(self, action: #selector(exitOptionsButtonTapped), for: UIControlEvents.touchUpInside)
 optionsScreen.addSubview(exitButton)*/

/*
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}

*/
