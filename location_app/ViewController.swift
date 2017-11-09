
import UIKit


class ViewController: UIViewController{
    let directionstr = "This game presents a series of riddles. Solve each one to discover the corresponding location. After arriving at your location, press 'check' to see if you are correct. \n You have 60 seconds for each riddle."

    @IBAction func infoButtonPressed(_ sender: UIButton) {
        loadAlert()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func start(_ sender: UIButton) {
    }
   
    @IBAction func toMainView(_ sender: UIStoryboardSegue) {
    }
 
    func loadAlert(){
        let alertController = UIAlertController(title: "Directions", message: directionstr, preferredStyle: .alert)
        
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
    
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
        

}

