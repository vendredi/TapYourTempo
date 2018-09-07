//
//  Calculate.swift
//  TapYourTempo
//
//  Created by Ted Sauerbrey on 2/6/18.
//  Copyright © 2018 Ted Sauerbrey. All rights reserved.
//

import UIKit

class Calculate {
    
    private func bpmFromAverageTempo(averageTempo: TimeInterval) -> Int {
        return Int(60 / averageTempo)
    }
    
    func getTempoFromLastThreeTaps(timeStampList: [TimeInterval]) -> Int {
        var beatsPerMinute = -1
        var mutableTimeStampList = timeStampList
        if mutableTimeStampList.count > 3 {
            mutableTimeStampList.removeFirst()
            // find the average of the last 3 taps
            let time1 = mutableTimeStampList[mutableTimeStampList.count - 3]
            let time2 = mutableTimeStampList[mutableTimeStampList.count - 2]
            let time3 = mutableTimeStampList[mutableTimeStampList.count - 1]
            let averageTempo = ((time3-time2) + (time2-time1))/2
            beatsPerMinute = bpmFromAverageTempo(averageTempo: averageTempo)
        }
        return beatsPerMinute
    }
    
    func getTempoFromTimeRange(seconds: Int, timeStampList: [TimeInterval]) -> Int {
        var beatsPerMinute = -1
        var mutableTimeStampList = timeStampList
        // has the range of seconds elapsed?
        if mutableTimeStampList[mutableTimeStampList.count - 1] - mutableTimeStampList[0] > Double(seconds-1) {

            // measure taps for a period of time
            let currentTime = CACurrentMediaTime()
            let timeToMeasureTaps: TimeInterval = TimeInterval(seconds)
            var itemsToRemove: [Int] = []
            // remove taps that occurred outside the specified range
            for i in 0..<mutableTimeStampList.count {
                if mutableTimeStampList[i] < currentTime - timeToMeasureTaps {
                    itemsToRemove.append(i)
                }
            }
            itemsToRemove.sort(by: >)
            for i in 0..<itemsToRemove.count {
                mutableTimeStampList.remove(at: itemsToRemove[i])
            }
            itemsToRemove.removeAll()
            
            // only continue if 2 or more taps remain in the array
            if mutableTimeStampList.count > 1 {
                // find average tempo of all taps
                var averageTempo: TimeInterval = 0
                var listOfTempos: [TimeInterval] = []
                for i in 0..<mutableTimeStampList.count-1 {
                    if i != mutableTimeStampList.count {
                        let time1 = mutableTimeStampList[i]
                        let time2 = mutableTimeStampList[i + 1]
                        listOfTempos.append(time2 - time1)
                    }
                }
                averageTempo = listOfTempos.reduce(0) { $0 + $1 } / Double(listOfTempos.count)
                beatsPerMinute = bpmFromAverageTempo(averageTempo: averageTempo)
            }
        }
        return beatsPerMinute
    }
}
