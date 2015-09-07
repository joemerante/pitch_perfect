//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Joe Merante on 9/5/15.
//  Copyright (c) 2015 JoeMerante. All rights reserved.
//

import Foundation

class RecordedAudio {
  var filePathURL: NSURL!
  var title: String!
  
  init(url: NSURL, title: String) {
    self.filePathURL = url
    self.title = title
  }
}