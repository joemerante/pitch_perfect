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
    try! player = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, fileTypeHint: nil)
    player.enableRate = true
    processingEngine = AVAudioEngine()
    try! audioFile = AVAudioFile(forReading: receivedAudio.filePathURL)
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
  
  @IBAction func playSoundSlow(sender: UIButton) {
    playAudioAtSpeed(0.5)
  }
  
  @IBAction func playSoundFast(sender: UIButton) {
    playAudioAtSpeed(1.7)
  }
  
  func playAudioAtSpeed(speed: Float) {
    resetAll()
    player.rate = speed
    player.play()
  }
  
  @IBAction func playChipmunkAudio(sender: UIButton) {
    playAudioWithVariablePitch(1000)
  }
  
  @IBAction func playDarthvaderAudio(sender: UIButton) {
    playAudioWithVariablePitch(-1000)
  }
  
  func playAudioWithVariablePitch(pitch: Float) {
    resetAll()
    
    let pitchPlayerNode = AVAudioPlayerNode()
    processingEngine.attachNode(pitchPlayerNode)
    
    let changePitchEffect = AVAudioUnitTimePitch()
    changePitchEffect.pitch = pitch
    processingEngine.attachNode(changePitchEffect)
    
    processingEngine.connect(pitchPlayerNode, to: changePitchEffect, format: audioFile.processingFormat)
    processingEngine.connect(changePitchEffect, to: processingEngine.outputNode, format: audioFile.processingFormat)
    
    pitchPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
    try! processingEngine.start()
    
    pitchPlayerNode.play()
  }
  
  @IBAction func stopSound(sender: UIButton) {
    resetAll()
  }
  
  func resetAll() {
    player.stop()
    player.currentTime = 0.0
    processingEngine.stop()
    processingEngine.reset()
  }

}
