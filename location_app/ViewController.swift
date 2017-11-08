
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var seconds=30
    var timer=Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.isHidden=true
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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach({
            location in
            print("Latitude:"+String(location.coordinate.latitude))
            print("Longitude:"+String(location.coordinate.longitude))
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("we got an error")
    }
    
    @IBAction func start(_ sender: UIButton) {
        Label.text="Go to the Kitchen, you have 5 seconds"
        timerLabel.isHidden=false
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        sender.isHidden=true
        
    }
    
    func updateTimer(){
        seconds -= 1
        timerLabel.text="\(seconds)"
        if seconds<=0{
            timer.invalidate()
        }
        
    }
    
}

