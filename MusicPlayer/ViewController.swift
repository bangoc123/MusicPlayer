//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Ngoc on 8/22/16.
//  Copyright © 2016 GDG. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var audio = AVAudioPlayer()
    
    var state = false
    
    @IBOutlet weak var sld_Volume: UISlider!
    
    @IBOutlet weak var btn_Play: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        audio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("runaway", ofType: ".mp3")!))
        audio.prepareToPlay()
        addThumbImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addThumbImage(){
        sld_Volume.setThumbImage(UIImage(named: "thumb2.png"), forState: .Normal)
        sld_Volume.setThumbImage(UIImage(named: "thumbHightLight3.png"), forState: .Highlighted)
    }
    
    
    @IBAction func action_silde(sender: AnyObject) {
        audio.volume = sender.value
    }
    
    @IBAction func action_Play(sender: UISlider) {
        
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

}

