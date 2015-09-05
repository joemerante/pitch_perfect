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
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewWillAppear(animated: Bool) {
    stopButton.hidden = true
    recordButton.enabled = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func recordAudio(sender: UIButton) {
    stopButton.hidden = false
    recordButton.enabled = false
    progressTextLabel.hidden = false
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
  
// TODO - figure out how to display multiple recordings, present in a table view to the user with file size, allow user to delete
//    let currentDateTime = NSDate()
//    let formatter = NSDateFormatter()
//    formatter.dateFormat = "ddMMyyyy-HHmmss"
//    let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "stopRecording") {
      let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
      let data = sender as! RecordedAudio
      playSoundsVC.receivedAudio = data 
    }
  }
  
  func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    if (flag) {
      // save the audio
      recordedAudio = RecordedAudio()
      recordedAudio.filePathURL = recorder.url
      recordedAudio.title = recorder.url.lastPathComponent
      // segue
      self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
    } else {
      println("Recording failed.")
      recordButton.enabled = true
      stopButton.hidden = true 
    }
  }

  @IBAction func stopRecording(sender: UIButton) {
    progressTextLabel.hidden = true
    audioRecorder.stop()
    var session = AVAudioSession.sharedInstance()
    session.setActive(false, error: nil)
  }
}

