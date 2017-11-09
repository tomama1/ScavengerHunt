//
//  ClueViewController.swift
//  location_app
//
//  Created by Anna on 11/8/17.
//  Copyright © 2017 Vlad. All rights reserved.
//

import UIKit
import CoreLocation


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

class ClueViewController: UIViewController,  CLLocationManagerDelegate {
    // ping pong room
   var p1 = (x: 0.0, y: 0.0)
   var p2 = (x: 0.0, y: 0.0)
   var p3 = (x: 0.0, y: 0.0)
   var p4 = (x: 0.0, y: 0.0)
    


    
    var p5 : (x: Double, y: Double)?
    
    
    var clueArray=["A place where messes are made, and messes are cleaned, where you can make yourself fat or make yourself lean", "In here, its sports day everyday","for i in 1..3{work hard for a month} \n then come here","I am soft in every bit, and a spot where you like to sit. What am I?"]
    
    var num:Int?
    
    
    var indexArray = [0,1,2,3,4]
    
    var randomIndex=Int(arc4random_uniform(UInt32(4)))
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    
    var seconds = 60
    var timer = Timer()
    
    var status = false
    var arraystatus = false
    @IBOutlet weak var timerLabel: UILabel!
    var locationManager: CLLocationManager?
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        print(locationManager?.location!.coordinate.longitude)
        print(locationManager?.location!.coordinate.latitude)
        p5 = (x: Double((locationManager?.location!.coordinate.latitude)!), y: Double((locationManager?.location!.coordinate.longitude)!))
        if performcheck(){
            status = true
            nextButton.isHidden = false
            commentLabel.isHidden = false
            commentLabel.text = "You are correct!"
            if indexArray.count == 1{
                performSegue(withIdentifier: "winSegue", sender:nil )
            }
        }
        
    }
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if arraystatus == true {
            indexArray = [0,1,2,3,4]
            arraystatus = false
        }
        seconds = 60
        nextButton.isHidden = true
        locationManager = CLLocationManager()
        num=randomIndex
        
        print("Random"+String(randomIndex))
        print("Num"+String(describing: num))
        
        clueLabel.text=clueArray[randomIndex]
        setVariables(int: randomIndex)
        indexArray = indexArray.filter { $0 != randomIndex }
        print(indexArray)
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
    
    func updateTimer(){
        seconds -= 1
        timerLabel.text="\(seconds)"
        if (status == true){

        }

        if seconds<=0{
            if (status == false){
                arraystatus = true
                performSegue(withIdentifier: "loseSegue", sender: nil)
            }
            timer.invalidate()
            
        }
        
    }
    func setVariables(int: Int){
        if int == 0 {
            p1 = (x: Double(34.1809720639).rounded(toPlaces: 7), y: Double(-118.309116633).rounded(toPlaces: 7))
            p2 = (x: Double(34.18097185439).rounded(toPlaces: 7), y: Double(-118.309033904).rounded(toPlaces: 7))
            p3 = (x: Double(34.1809433978).rounded(toPlaces: 7), y: Double(-118.308900296).rounded(toPlaces: 7))
            p4 = (x: Double(34.18092527792).rounded(toPlaces: 7), y: Double(-118.308996714).rounded(toPlaces: 7))
        }
        else if int == 1 {
            p1 = (x: Double(34.18072727046).rounded(toPlaces: 7), y: Double(-118.309234231).rounded(toPlaces: 7))
            p2 = (x: Double(34.18067027352).rounded(toPlaces: 7), y: Double(-118.309237165).rounded(toPlaces: 7))
            p3 = (x: Double(34.1806754283).rounded(toPlaces: 7), y: Double(-118.309255186).rounded(toPlaces: 7))
            p4 = (x: Double(34.1807638993).rounded(toPlaces: 7), y: Double(-118.309254180).rounded(toPlaces: 7))
        }
        else if int == 2 {
            p1 = (x: Double(34.180775801683).rounded(toPlaces: 7), y: Double(-118.309331378).rounded(toPlaces: 7))
            p2 = (x: Double(34.18081758547).rounded(toPlaces: 7), y: Double(-118.309386279).rounded(toPlaces: 7))
            p3 = (x: Double(34.18083087078).rounded(toPlaces: 7), y: Double(-118.309385944).rounded(toPlaces: 7))
            p4 = (x: Double(34.18076071425).rounded(toPlaces: 7), y: Double(-118.30936223).rounded(toPlaces: 7))
        }
        else{
            p1 = (x: Double(34.1807240434).rounded(toPlaces: 7), y: Double(-118.309318218).rounded(toPlaces: 7))
            p2 = (x: Double(34.18071230876).rounded(toPlaces: 7), y: Double(-118.309364151).rounded(toPlaces: 7))
            p3 = (x: Double(34.18069634124).rounded(toPlaces: 7), y: Double(-118.309365743).rounded(toPlaces: 7))
            p4 = (x: Double(34.1807823395).rounded(toPlaces: 7), y: Double(-118.309276308).rounded(toPlaces: 7))
        }
        
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {

        nextButton.isHidden=true
        let randomIndex=indexArray[Int(arc4random_uniform(UInt32(indexArray.count-1)))]
        num=randomIndex
        print("nextRandom"+String(randomIndex))
        print("nextNum"+String(describing: num))
        clueLabel.text=clueArray[randomIndex]
        commentLabel.isHidden=true
        seconds = 61
        indexArray = indexArray.filter { $0 != randomIndex }
        setVariables(int: randomIndex)
        print (indexArray)
        status = false

    }
    

    
    func performcheck() -> Bool {
        
        let triangle1 = createtrianglearea(point1: p1, point2: p2, point3: p5!)
        let triangle2 = createtrianglearea(point1: p2, point2: p3, point3: p5!)
        let triangle3 = createtrianglearea(point1: p3, point2: p4, point3: p5!)
        let triangle4 = createtrianglearea(point1: p4, point2: p1, point3: p5!)
        
        
        let recarea = createarea(point1: p1, point2: p2, point3: p3, point4: p4)
        let triarea = triangle1+triangle2+triangle3+triangle4
        
        print(Int(recarea))
        print(Int(triarea))
        print(Int(recarea) == Int(triarea))

        if ((triarea - recarea) < 0.5){
            return true
        }
        return false
    }
    
    func createtrianglearea(point1: (x: Double, y:Double), point2: (x: Double, y:Double), point3: (x: Double, y:Double)) -> Double{
        let area = abs(((point1.x*(point2.y-point3.y))+(point2.x*(point3.y-point1.y))+(point3.x*(point1.y-point2.y)))/2.0)
        return area*100000000
    }
    
    func createarea(point1: (x: Double, y:Double), point2: (x: Double, y:Double), point3: (x: Double, y:Double), point4: (x: Double, y:Double)) -> Double {
        let area = abs(((point1.x*point2.y - point1.y*point2.x) + (point2.x*point3.y - point2.y*point3.x) + (point3.x*point4.y - point3.y*point4.x) + (point4.x*point1.y - point4.y*point1.x))/2.0)
        return area*100000000
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



    
}
