//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Joe Merante on 8/31/15.
//  Copyright (c) 2015 JoeMerante. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
  
  var player:AVAudioPlayer!
  var processingEngine:AVAudioEngine!
  var receivedAudio:RecordedAudio!
  var audioFile: AVAudioFile!

  override func viewDidLoad() {
    super.viewDidLoad()
    player = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
    player.enableRate = true
    processingEngine = AVAudioEngine()
    audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  func playAudioAtSpeed(speed: Float) {
    player.stop()
    player.rate = speed
    player.play()
  }
  
  @IBAction func playSoundSlow(sender: UIButton) {
    playAudioAtSpeed(0.5)
  }
  
  @IBAction func playSoundFast(sender: UIButton) {
    playAudioAtSpeed(1.7)
  }
  
  @IBAction func playChipmunkAudio(sender: UIButton) {
    playAudioWithVariablePitch(1000)
  }
  
  function playAudioWithVariablePitch(pitch: Float) {
    resetAll()
    
    var pitchPlayerNode = AVAudioPlayerNode()
    processingEngine.attachNode(pitchPlayerNode)
    
    var changePitchEffect = AVAudioUnitTimePitch()
    changePitchEffect.pitch = pitch
    processingEngine.attachNode(changePitchEffect)
    
    processingEngine.connect(pitchPlayerNode, to: changePitchEffect, format: audioFile.processingFormat)
    processingEngine.connect(changePitchEffect, to: processingEngine.outputNode, format: audioFile.processingFormat)
    
    pitchPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
    processingEngine.startAndReturnError(nil)
    
    pitchPlayerNode.play()
  }
  
  @IBAction func stopSound(sender: UIButton) {
    player.stop()
    player.currentTime = 0.0
  }
  
  func resetAll() {
    player.stop()
    processingEngine.stop()
    processingEngine.reset()
  }

}
