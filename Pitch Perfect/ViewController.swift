//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Joe Merante on 8/29/15.
//  Copyright (c) 2015 JoeMerante. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var progressTextLabel: UILabel!
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var recordButton: UIButton!
  
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
    //TODO: record the user's voice
    stopButton.hidden = false
    recordButton.enabled = false
    progressTextLabel.hidden = false
  }

  @IBAction func stopRecording(sender: UIButton) {
    progressTextLabel.hidden = true
  }
}

