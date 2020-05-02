//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Hanoudi on 4/29/20.
//  Copyright © 2020 Hans. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    // MARK: RecordSoundsViewController Variables
    // to reference audioRecorder in RecordSoundsViewController
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet var recordingLabel: UILabel!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopRecordingButton: UIButton!
    
    // MARK:- RecordSoundsViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(recordState: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    // MARK: RecordSoundsViewController UI Methods
    @IBAction func recordAudio(_ sender: Any) {
    configureUI(recordState: true)
    
    // gets App document directory and store it as a string in dirPath
    // path array creates a full directory to our record
    let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as String
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = URL(string: pathArray.joined(separator: "/"))
    
    // start audio session, shared for only one hardware for all apps
    // make this controller the audio's delegate
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
    
    try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
    audioRecorder.delegate = self
    audioRecorder.isMeteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
    configureUI(recordState: false)
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // send path and perform segue
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("failed")
        }
    }
    
    func configureUI(recordState RecordState: Bool) {
        switch(RecordState) {
        case true:
            recordingLabel.text = "Recording in Progress"
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        case false:
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
            recordingLabel.text = "Tap to Record"
        }
    }

}

