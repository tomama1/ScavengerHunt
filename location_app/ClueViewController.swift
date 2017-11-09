//
//  ClueViewController.swift
//  location_app
//
//  Created by Anna on 11/8/17.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit
import CoreLocation


class ClueViewController: UIViewController,  CLLocationManagerDelegate {
    var clueArray=["I'm hungry, where do I go? You have 30 seconds", "Time to exercise, where do I go? 30 seconds:)","You're getting warmer, go to the room where you solve challenging problems, 30 seconds:)","Look around for the hidden treasure, Hint it's stashed in a box and is edible, 30 seconds:)"]
    var num:Int?
    var commentArray=["Correct, you arrived at the Dojo Kitchen, tap below for next clue","Correct!, you arrived at the Ping Pong Room, tap below for next clue","Great! You arrived at the Algo room!", "Great Job! You deserve a lollipop!"]
//    var randomIndex: Int?
    lazy var randomIndex=Int(arc4random_uniform(UInt32(4)))
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    var seconds = 30
    var timer = Timer()
    var status = false
    
    @IBOutlet weak var timerLabel: UILabel!
    var locationManager: CLLocationManager?
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isHidden = true
        locationManager = CLLocationManager()
//        let randomIndex=Int(arc4random_uniform(UInt32(numArray.count)))
        num=randomIndex
        print("Random"+String(randomIndex))
        print("Num"+String(describing: num))
        clueLabel.text=clueArray[randomIndex]
        clueArray.remove(at: randomIndex)
        commentLabel.text=""
        
        
        if let manager = locationManager {
            print("We have a manager")
            manager.delegate = self
            manager.requestAlwaysAuthorization()
            manager.requestLocation()
            manager.startUpdatingLocation()
        } else {
            print("no manager")
        }

        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ClueViewController.updateTimer)), userInfo: nil, repeats: true)
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        nextButton.isHidden=true
        let randomIndex=Int(arc4random_uniform(UInt32(commentArray.count)))
        num=randomIndex
        print("nextRandom"+String(randomIndex))
        print("nextNum"+String(describing: num))
        clueLabel.text=clueArray[randomIndex]
        commentLabel.isHidden=true
        clueArray.remove(at: randomIndex)
        timerLabel.isHidden=false
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ClueViewController.updateTimer)), userInfo: nil, repeats: true)
//        performSegue(withIdentifier: "winSegue", sender:nil )
//

        
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach({
            location in
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("we got an error")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "winSegue"{
            let winController = segue.destination as! winViewController
        }
        else if segue.identifier == "loseSegue"{
            let loseController = segue.destination as! loseViewController
        }
    }
    //using testPressed button to mimick location entrance
//    @IBAction func testPressed(_ sender: UIButton) {
//        nextButton.isHidden = false
//        timerLabel.isHidden=true
//        
//        clueLabel.text=""
//        commentLabel.isHidden=false
//        commentLabel.text=commentArray[randomIndex]
//        timer.invalidate()
//        
//    }
    func LocationReached(){
        //coordinate destinations should go here
        
        
    }

    func updateTimer(){
        seconds -= 1
        timerLabel.text="\(seconds)"
        if (status == true){
            nextButton.isHidden = false
        }
        if seconds<=0{
            if (status == false){
                performSegue(withIdentifier: "loseSegue", sender: nil)
            }
            timer.invalidate()
            
        }

        
    }
}
