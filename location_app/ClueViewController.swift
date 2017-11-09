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
    var seconds = 30
    var timer = Timer()
    var status = false
    
    var locationManager: CLLocationManager?
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isHidden = true
        locationManager = CLLocationManager()
        
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
        performSegue(withIdentifier: "winSegue", sender:nil )
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
    
    

    func updateTimer(){
        seconds -= 1
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
