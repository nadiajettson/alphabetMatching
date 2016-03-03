//
//  ViewController.swift
//  alphabetMatching
//
//  Created by MacBook on 2/24/16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var letterOutput: UILabel!
    @IBOutlet weak var button1Output: UIButton!
    @IBOutlet weak var button2Output: UIButton!
    @IBOutlet weak var button3Output: UIButton!
    @IBOutlet weak var feedback: UILabel!
    
    @IBOutlet weak var token1: UIImageView!
    @IBOutlet weak var token2: UIImageView!
    @IBOutlet weak var token3: UIImageView!
    @IBOutlet weak var token4: UIImageView!
    @IBOutlet weak var token5: UIImageView!
   
    
    let letters = ["A", "B", "C", "D", "E", "F",
                    "G", "H", "I", "J", "K", "L",
                    "M", "N", "O", "P", "Q", "R",
                    "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    let images: [UIImage] = [UIImage(named: "shark.png")!,
                            UIImage(named: "nemo.png")!,
                            UIImage(named: "nemo2.png")!,
                            UIImage(named: "seagull.png")!,
                            UIImage(named: "lobster.png")!,
                            UIImage(named: "octupus.png")!,
                            UIImage(named: "seal.png")!,
                            UIImage(named: "turtle.png")!,
                            UIImage(named: "dolphin.png")!,
                            UIImage(named: "seahorse.png")!]
    
    

    var randomImages = 0
    var randomLetter = 0
    var randomButton = 0
    var tokenBox = 0
    var points = 0
    var numOfAnswerAttempts = 0
    
    var audioPlayer : AVAudioPlayer!
    
    let incorrectURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("no", ofType: "wav")!)
    let goodJobURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("goodJob", ofType: "wav")!)
    let niceURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("nice", ofType: "wav")!)
    let way2GoURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("way2Go", ofType: "wav")!)
    let wowURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wow", ofType: "wav")!)
    let youDidItURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("youDidIt", ofType: "wav")!)
    let yeahURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("yeahCheer", ofType: "wav")!)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGame()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /* Game manipulations */
    
    func newGame(){
        
        randomLetter = Int(arc4random_uniform(26))
        letterOutput.text = "\(letters[randomLetter])"
        
        randomButton = Int(arc4random_uniform(3))
        
        var lettersCopy = letters
        lettersCopy.removeAtIndex(randomLetter)
        let fakeAnswer1 = Int(arc4random_uniform(25))
        
        var lettersCopyCopy = lettersCopy
        lettersCopyCopy.removeAtIndex(fakeAnswer1)
        let fakeAnswer2 = Int(arc4random_uniform(24))
        
        
        if randomButton == 0{
            button1Output.setTitle("\(letters[randomLetter])", forState: UIControlState.Normal)
            button2Output.setTitle("\(lettersCopy[fakeAnswer1])", forState: UIControlState.Normal)
            button3Output.setTitle("\(lettersCopyCopy[fakeAnswer2])", forState: UIControlState.Normal)
            
        }
        if randomButton == 1{
            button2Output.setTitle("\(letters[randomLetter])", forState: UIControlState.Normal)
            button1Output.setTitle("\(lettersCopy[fakeAnswer1])", forState: UIControlState.Normal)
            button3Output.setTitle("\(lettersCopyCopy[fakeAnswer2])", forState: UIControlState.Normal)
            
        }
        if randomButton == 2{
            button3Output.setTitle("\(letters[randomLetter])", forState: UIControlState.Normal)
            button2Output.setTitle("\(lettersCopy[fakeAnswer1])", forState: UIControlState.Normal)
            button1Output.setTitle("\(lettersCopyCopy[fakeAnswer2])", forState: UIControlState.Normal)
        }
        
    }                                                                                          
    
    // this functions purpose is to decide whether you go to next page
    // or you reset the game
    func checkIfGameisOver() {
        // Check if game is over
        if numOfAnswerAttempts == 5 {
            // The game is over now decide
            // what to do
            delay(2.0, closure: {
               self.process()
            })
        } else {
            
            // if correct newgame
            // else try 3 times and then
            
            newGame()
        }
    }
    
    // this decides whether to reset game or go to next page
    func process() {
        if points == 5 {
            // go to next page
            let gameComplete = storyboard?.instantiateViewControllerWithIdentifier("gameCompleteViewID") as! gameCompleteViewController
            presentViewController(gameComplete, animated:  true, completion:  nil)
        } else {
            // reset game
            resetGame()
        }
    }
    
    func resetGame() {
        token1.image = UIImage()
        token2.image = UIImage()
        token3.image = UIImage()
        token4.image = UIImage()
        token5.image = UIImage()

        randomImages = 0
        randomLetter = 0
        randomButton = 0
        tokenBox = 0
        points = 0
        numOfAnswerAttempts = 0
        newGame()
    }
    
    /*
        Button Functions
    */
    
    @IBAction func button1(sender: AnyObject) {
        
        if randomButton == 0 {
            correct()

        }else{
            incorrect()
        }
        
        numOfAnswerAttempts += 1
        checkIfGameisOver()
    }
    
    @IBAction func button2(sender: AnyObject) {
        if randomButton == 1 {
            correct()
        } else {
            incorrect()
        }
        
        numOfAnswerAttempts += 1
        checkIfGameisOver()
    }

    @IBAction func button3(sender: AnyObject) {
        if randomButton == 2 {
            correct()
        } else {
            incorrect()
        }
        
        numOfAnswerAttempts += 1
        checkIfGameisOver()
    }
    
    /* Corrects and incorrect */
    
    func correct(){
        feedback.textColor = UIColor.greenColor()
        feedback.text = "CORRECT"
        
        let randomCorrectSound = Int(arc4random_uniform(6))
        if randomCorrectSound == 0{
            audioPlayer = AVAudioPlayerPool.playerWithURL(goodJobURL)
            audioPlayer.play()
        }
        if randomCorrectSound == 1{
            audioPlayer = AVAudioPlayerPool.playerWithURL(niceURL)
            audioPlayer.play()
            
        }
        if randomCorrectSound == 2{
            audioPlayer = AVAudioPlayerPool.playerWithURL(way2GoURL)
            audioPlayer.play()
        }
        if randomCorrectSound == 3{
            audioPlayer = AVAudioPlayerPool.playerWithURL(wowURL)
            audioPlayer.play()
        }
        if randomCorrectSound == 4{
            audioPlayer = AVAudioPlayerPool.playerWithURL(youDidItURL)
            audioPlayer.play()
        }
        if randomCorrectSound == 5{
            audioPlayer = AVAudioPlayerPool.playerWithURL(yeahURL)
            audioPlayer.play()
        }
        
        audioPlayer.delegate = self
        
        
        randomImages = Int(arc4random_uniform(10))
        
        if tokenBox == 0{
            token1.image = images[randomImages]
            
        }
        if tokenBox == 1{
            token2.image = images[randomImages]

        }
        if tokenBox == 2{
            token3.image = images[randomImages]

        }
        if tokenBox == 3{
            token4.image = images[randomImages]

        }
        if tokenBox == 4{
            token5.image = images[randomImages]

        }
        
        tokenBox += 1
        points += 1
    }
    
    func incorrect(){
        feedback.textColor = UIColor.redColor()
        feedback.text = "NO"
        audioPlayer = AVAudioPlayerPool.playerWithURL(incorrectURL)
        audioPlayer.play()
        
        if tokenBox == 0{
            token1.image = UIImage(named: "xWrong.png")
        }
        if tokenBox == 1{
            token2.image = UIImage(named: "xWrong.png")
        }
        
        if tokenBox == 2{
            token3.image = UIImage(named: "xWrong.png")
        }
        
        if tokenBox == 3{
            token4.image = UIImage(named: "xWrong.png")
        }
        
        if tokenBox == 4{
            token5.image = UIImage(named: "xWrong.png")

        }
    
        tokenBox += 1
    }
    
    /* Helper functions */
    
    func delay(delay: Double, closure: () ->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),dispatch_get_main_queue(), closure)
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("Audio Finished")
    }
    
}

