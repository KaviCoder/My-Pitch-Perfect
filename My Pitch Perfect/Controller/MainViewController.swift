//
//  MainViewController.swift
//  My Pitch Perfect
//
//  Created by Kavya Joshi on 6/30/21.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController,AVAudioRecorderDelegate {
    
    //MARK:- AVAudioRecorder instance is created here
    var myRecorder : AVAudioRecorder!

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stopButton.isEnabled = false
    }
    @IBAction func recordButtonPressed(_ sender: UIButton) {
       
        configureUI(recording: true)
        //MARK:- Make a url to save the recording
        
        let URL = getFileUrl()
        //print(URL)
        let session = AVAudioSession.sharedInstance()
        do {
        try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)

               try myRecorder = AVAudioRecorder(url: URL, settings: [:])
            myRecorder.delegate = self
            myRecorder.isMeteringEnabled = true
            myRecorder.prepareToRecord()
            myRecorder.record()
        }
        catch{
            print(error)
        }
        
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        configureUI(recording: false)
        // stop recording
        
        myRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        do
        {try session.setActive(false)
            
            
        }
        catch{
            print(error)
        }
     
    }
    
    //MARK:- AV Audio Recorder Delegate function -- this will be automatically triggered when our audio is recorded.and tells if it is successful or not
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "ToOptions", sender: myRecorder.url)
        }
        else{
        print("audio not saved successfully")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToOptions"
        {
            let dvc = segue.destination as! OptionsViewController
            let recordedURL = sender as! URL
            dvc.recordedAudioURL = recordedURL
            
        }
    }
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func getFileUrl() -> URL
    {
        let filename = "myRecording.m4a"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
    return filePath
    }
    
    func configureUI(recording :Bool )
    {
        if recording{
            recordText.text = "Recording..."
            recordButton.isEnabled = false
            stopButton.isEnabled = true
            
        }
        else{
            recordText.text = "Tap to record"
            stopButton.isEnabled = false
            recordButton.isEnabled = true
            
        }
    }


}

