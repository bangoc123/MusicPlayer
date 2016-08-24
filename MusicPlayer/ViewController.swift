//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Ngoc on 8/22/16.
//  Copyright © 2016 GDG. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var audio = AVAudioPlayer()
    
    var state = false
    
    @IBOutlet weak var lbl_PlayedTime: UILabel!
    
    @IBOutlet weak var lbl_TotalTime: UILabel!
    
    @IBOutlet weak var sld_Duration: UISlider!
    
    @IBOutlet weak var sld_Volume: UISlider!
    
    @IBOutlet weak var btn_Play: UIButton!
    
    
    @IBOutlet weak var switch_Repeat: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        audio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("runaway", ofType: ".mp3")!))
        
        audio.prepareToPlay()
        
        addThumbImage()
        
        addThumbImageDuration()
        
        lbl_TotalTime.text = secondsToMinutesSeconds(audio.duration)
        
        self.sld_Duration.value = 0
        
        self.sld_Volume.value = audio.volume
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(updatePlayedTime), userInfo: nil, repeats: true)
        
        if(switch_Repeat.on){
            audio.numberOfLoops = -1
        }else{
            audio.numberOfLoops = 0
        }
        
        audio.delegate = self
        
    }
    
    
    func updatePlayedTime(){
        self.lbl_PlayedTime.text = secondsToMinutesSeconds(audio.currentTime)
        self.sld_Duration.value = Float(audio.currentTime/audio.duration)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addThumbImage(){
        sld_Volume.setThumbImage(UIImage(named: "thumb2.png"), forState: .Normal)
        sld_Volume.setThumbImage(UIImage(named: "thumbHightLight3.png"), forState: .Highlighted)
    }
    
    func addThumbImageDuration(){
        sld_Duration.setThumbImage(UIImage(named: "duration.png"), forState: .Normal)
    }
    
    
    @IBAction func action_slideToFastForward(sender: UISlider) {
        audio.currentTime =  audio.duration*Double(sender.value)
        //print(audio.duration*Double(sender.value))
    }
    
    
    
    @IBAction func action_silde(sender: AnyObject) {
        audio.volume = sender.value
    }
    
    @IBAction func action_Play(sender: UIButton) {
        
        if(state == false){
            audio.play()
            btn_Play.setImage(UIImage(named: "pause2.png"), forState: .Normal)
            state = true
        }else{
            audio.pause()
            btn_Play.setImage(UIImage(named: "play2.png"), forState: .Normal)
            state = false
        }
    }
    


    @IBAction func action_SwitchToRepeat(sender: UISwitch) {
        if(sender.on){
            audio.numberOfLoops = -1
        }else{
            audio.numberOfLoops = 0
        }
        
    }
    
    
    func secondsToMinutesSeconds(seconds: Double) -> String{
        
        let minutes = Int(seconds/60)
        
        let seconds = Int(seconds%60)
        
        var minutesToString = String(minutes)
        
        var secondsToString = String(seconds)
        
        if(minutes<10){
            
            minutesToString = "0" + String(minutes)
            
        }
        
        if(seconds<10){
            secondsToString = "0" + String(seconds)
        }
        return  minutesToString + ":" + secondsToString
        
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if(switch_Repeat.on == false){
            btn_Play.setImage(UIImage(named: "play2.png"), forState: .Normal)
            state = false
        }
    }
    
    

}

