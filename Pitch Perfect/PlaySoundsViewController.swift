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

  override func viewDidLoad() {
    super.viewDidLoad()
    if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
      let fileURL = NSURL.fileURLWithPath(filePath)
      player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
      player.enableRate = true
    } else {
      println("the file path is empty")
    }
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
  
  @IBAction func stopSound(sender: UIButton) {
    player.stop()
    player.currentTime = 0.0
  }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
