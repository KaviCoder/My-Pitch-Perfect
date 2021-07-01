//
//  OptionsViewController.swift
//  My Pitch Perfect
//
//  Created by Kavya Joshi on 6/30/21.
//

import UIKit
import AVFoundation

class OptionsViewController: UIViewController {

    var recordedAudioURL : URL!
    // MARK: Outlets

    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    //For changing the audio
 
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
     //2.
        configureUI(.notPlaying)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1.
        setupAudio()
       
        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
  //3.
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play Sound Button Pressed")
        
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

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
    }
   
}
