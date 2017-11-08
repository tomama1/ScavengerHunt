
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    @IBOutlet weak var getLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
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
            let str1="Latitude:"+String(location.coordinate.latitude)
            let str2="Longitude:"+String(location.coordinate.longitude)
            let str3="Altitude:"+String(location.altitude)
            let str4="Timestamp:"+String(describing: location.timestamp)
            let str=String(str1+str2+str3+str4)
            getLabel.text=str
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("we got an error")
    }
    
    
}

