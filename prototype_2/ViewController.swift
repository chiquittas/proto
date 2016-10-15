//
//  ViewController.swift
//  prototype_2
//
//  Created by Yulia B on 10/9/16.
//  Copyright © 2016 Yulia. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    // MARK: Properties
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var myAudioPlayer =  AVAudioPlayer()
    var pictures = [String]()
    var sound: String = ""
    
    var counter = 0
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        print("the tap")

        
    }
  
    /*
    ////////////////////////////////////
    // TODO:
    // - Gimp the slides
    // - Gimp the LaunchScreen
    // - Check transition animation for swipe gesture (on iPhone)
    // - Check layout on all devices
    // - Icon, name
    // - Check sorting for more than 10 imgs
    // - Check long audio playback (iPhone)
    // -  
    // - setup Git repo
    /////////////////
    */
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   //     print ("View did load")
        
        // Get path for image and sound resources
        pictures = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: "res/images")
        sound = NSBundle.mainBundle().pathForResource("vnc", ofType: "mp3", inDirectory: "res/sounds")!

        imageView.image = UIImage( contentsOfFile: pictures[counter] )
        
        
//Player initialization
        if let myFilePathString = NSBundle.mainBundle().pathForResource ("vnc", ofType: "mp3", inDirectory: "res/sounds") //("avoir l ame chevillee au corps", ofType: "mp3") //
        {
            let myFilePathURL = NSURL(fileURLWithPath: myFilePathString)

        do{
                
        try myAudioPlayer = AVAudioPlayer (contentsOfURL: myFilePathURL)
            
            myAudioPlayer.delegate = self
        }catch
            {
                print("error")
                soundButton.selected = false
            }
        }
        
/*
        if myAudioPlayer.duration == myAudioPlayer.currentTime {
            print ("track has finished")
            soundButton.selected = false
        }
*/
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onSoundButtonTap(sender: AnyObject) {
        print("sound button tapped")
        playSound()
        
        

    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully: Bool){
        print("finished playing")
        soundButton.selected = false
    
    }
    
    func playSound() {
        
        // If player is already playing pause. If not start/resume playback
        // set button state

        if myAudioPlayer.playing{
                    myAudioPlayer.pause()
                    print("dur - ", myAudioPlayer.currentTime)
                    soundButton.selected = false
                } else {
                    myAudioPlayer.play()
                    
                    soundButton.selected = true
                }
    }
    
    
    @IBAction func onSwipeRightToLeft(sender: UISwipeGestureRecognizer) {
        counter += 1
        print ("Swipe right to left. ")
        
        if counter > pictures.count-1 { //carousel effect
            counter = 0
        }
        print("Picture at path: ", pictures[counter])
        
        imageView.image = UIImage (contentsOfFile: pictures[counter])

    }

    @IBAction func onSwipeLeftToRight(sender: UISwipeGestureRecognizer) {
        
        counter -= 1
        print ("Swipe left to right. ")
        
        if counter < 0  { //carousel effect
            counter = pictures.count-1
        }
        print("Picture at path: ", pictures[counter])
        
        imageView.image = UIImage (contentsOfFile: pictures[counter])

    }
}

