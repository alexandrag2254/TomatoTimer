//
//  ViewController.swift
//  tomatoTimer
//
//  Created by Jie on 8/21/15.
//  Copyright © 2015 Jie. All rights reserved.
//

import Cocoa
import AVFoundation

class ViewController: NSViewController {
    
    var timer = NSTimer()
    var timeLeft = 30 //1500
    var timeStopped = false
    
    var audioPlayer:AVAudioPlayer!
    var volume: Float = 0.0
    
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var ssButton: NSButton!
    
    @IBAction func tomatoButton(sender: NSButton) {
        timeLeft = 30
        timeLabel.stringValue = "00:30"
        timeStopped = true
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateUI", userInfo: nil, repeats: true)
    }
    
    @IBAction func breakButton(sender: NSButton) {
        //5min break
        timeLeft = 300
        timeLabel.stringValue = "05:00"
        timeStopped = false
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateUI", userInfo: nil, repeats: true)
    }
    
    
    
    @IBAction func stopButton(sender: NSButton) {
        if timeStopped == false {
            //want to stop time
            ssButton.title = "Start"
            timer.invalidate()
            timeStopped = true
        } else {
            //restart time
            ssButton.title = "Stop"
            timeStopped = false
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateUI", userInfo: nil, repeats: true)
        }
    }
    
    func updateUI() {
        timeLeft -= 1
        var currentTime = timeLeft
        let minutes = Int(currentTime/60)
        currentTime -= minutes * 60
        let seconds = Int(currentTime)
        
        let strMinutes = minutes > 9 ? String(minutes): "0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds): "0" + String(seconds)
        
        timeLabel.stringValue = "\(strMinutes):\(strSeconds)"
        
        if timeLabel.stringValue == "00:05" {
            //////start song ////////////////
        
                let audioFilePath1 = NSBundle.mainBundle().pathForResource("countdown", ofType: "mp3")
        
                if audioFilePath1 != nil {
            
                let audioFileUrl1 = NSURL.fileURLWithPath(audioFilePath1!)
            
                audioPlayer = try! AVAudioPlayer(contentsOfURL: audioFileUrl1, fileTypeHint: nil)
                audioPlayer.play()
            
            } else {
                print("audio file is not found")
            }
            /////////////////////////////////

        }
        
        if timeLabel.stringValue == "00:00" {
            timer.invalidate()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateUI", userInfo: nil, repeats: true)

    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

