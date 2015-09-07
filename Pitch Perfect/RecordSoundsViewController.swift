//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Joe Merante on 8/29/15.
//  Copyright (c) 2015 JoeMerante. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
  
  @IBOutlet weak var progressTextLabel: UILabel!
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var recordButton: UIButton!
  
  var audioRecorder:AVAudioRecorder!
  var recordedAudio:RecordedAudio!

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    progressTextLabel.text = "Tap to record"
    recordButton.enabled = true
    stopButton.hidden = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func recordAudio(sender: UIButton) {
    stopButton.hidden = false
    recordButton.enabled = false
    progressTextLabel.text = "Recording in progress..."
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
  
    let recordingName = "my_audio.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = NSURL.fileURLWithPathComponents(pathArray)
    
    var session = AVAudioSession.sharedInstance()
    session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
    
    audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
    audioRecorder.delegate = self
    audioRecorder.meteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()

  }
  
  func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    if (flag) {
      recordedAudio = RecordedAudio(url: recorder.url, title: recorder.url.lastPathComponent!)
      self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
    } else {
      recordButton.enabled = true
      stopButton.hidden = true
    }
  }

  @IBAction func stopRecording(sender: UIButton) {
    audioRecorder.stop()
    var session = AVAudioSession.sharedInstance()
    session.setActive(false, error: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "stopRecording") {
      let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
      let data = sender as! RecordedAudio
      playSoundsVC.receivedAudio = data
    }
  }
}

