//
//  JMPTimer.swift
//  JMPTimer
//
//  Created by John Peden on 7/26/16.
//  Copyright © 2016 John Peden. All rights reserved.
//

import Foundation
import UIKit

class JMPTimer {

  private var days = 0
  private var hours = 0
  private var minutes = 0
  private var seconds = -1
  private var miliseconds = 0
  
  /// Timer UILabel.
  var timerLabel = UILabel()
  
  /// Timer class object.
  var timer = Timer()
  
  /// Variable that lets you know if the timer is running.
  private var timerRunning = false
  
  /// Holds the time as a string, and will set timerLabel's text.
  var timeAsString = "" {
    willSet {
      timerLabel.text = "\(newValue)"
    }
  }
  
  init() {
  }

  init(withLabel label: UILabel) {
    timerLabel = label
  }
  
  /// Increments seconds, minutes, hours, days accordingly and updates timeAsString.
  @objc func updateTimer() {
    seconds += 1
    if seconds == 60 {
      minutes += 1
      seconds = 0
      if minutes == 60 {
        hours += 1
        minutes = 0
        if hours == 24 {
          days += 1
          hours = 0
        }
      }
    }
    timeAsString = String(format: "%02d:%02d", minutes, seconds)
    print(timeAsString)
  }
  
  /// Starts timer by starting timer and setting timerRunning to true.
  func start() {
    if !IsTimerRunning() {
      SetTimerRunning(true)
      let selector = #selector(JMPTimer.updateTimer)
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: selector, userInfo: nil, repeats: true)
      timer.fire()
    }
  }
  
  /// Stops timer and sets timerRunning to false.
  func stop() {
    SetTimerRunning(false)
    timer.invalidate()
  }
  
  /// Clears time.
  func clear() {
    timeAsString = "00:00"
    seconds = -1
    minutes = 0
    hours = 0
    days = 0
  }
  
  /// This function returns timerRunning.
  /// - Returns: timerRunning class variable
  func IsTimerRunning() -> Bool {
    return timerRunning
  }
  
  /// This function sets timerRunning
  /// - Parameter TimerIsRunning: What to set timerRunning to
  func SetTimerRunning(_ TimerIsRunning: Bool) {
    timerRunning = TimerIsRunning
  }
}
