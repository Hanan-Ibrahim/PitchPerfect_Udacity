//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Hanoudi on 4/29/20.
//  Copyright © 2020 Hans. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    enum ButtonType: Int { case slow = 0, fast, chipmunk, vader, echo, reverb}

    // MARK:- Variables
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
        
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var snailButton: UIButton!
    @IBOutlet var rabbitButton: UIButton!
    @IBOutlet var chipmunkButton: UIButton!
    @IBOutlet var vaderButton: UIButton!
    @IBOutlet var echoButton: UIButton!
    @IBOutlet var reverbButton: UIButton!
    
    // MARK:- PlaySoundsViewController Methods
    @IBAction func playSoundForButton(_ sender: UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject){
        stopAudio()
    }
    
    // MARK:- PlaySoundsController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
}
