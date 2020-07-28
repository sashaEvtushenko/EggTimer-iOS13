//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let boilingTimes = ["Soft" : 3, "Medium" : 4, "Hard" : 7]
    var passedTime: Int = 0
    var totalTime: Int = 0
    var timer = Timer()
    var player = AVAudioPlayer()
    
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        guard let hardness = sender.titleLabel?.text, let boilingTime = boilingTimes[hardness] else { return }
        topLabel.text = hardness
        passedTime = 0
        totalTime = boilingTime
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }
    
    @objc func startTimer() {
        if passedTime < totalTime {
            passedTime += 1
            progressView.progress = Float(passedTime) / Float(totalTime)
        } else {
            topLabel.text = "Done!"
            playSound()
            timer.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.topLabel.text = "How do you like your eggs?"
            }
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
    
}
