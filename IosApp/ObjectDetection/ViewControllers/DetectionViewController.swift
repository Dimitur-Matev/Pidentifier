import Foundation
import UIKit

class DetectionViewController: UIViewController {
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    

    @IBOutlet var hdmiDescription : UILabel!
    
    override func viewDidLoad() {


        hdmiDescription.text = "A USB port is a standard cable \nconnection interface for personal computers and \nconsumer electronics devices. USB stands for \nUniversal Serial Bus, an industry standard \nfor short-distance digital data communications. USB \nports allow USB \ndevices to be connected to each other with \nand transfer digital data over USB cables."
        hdmiDescription.numberOfLines = 0
        hdmiDescription.translatesAutoresizingMaskIntoConstraints = false
        hdmiDescription.lineBreakMode = .byWordWrapping
        
        image1.image = UIImage(named: "usb_port1")
        image2.image = UIImage(named: "usb_port2")
        image3.image = UIImage(named: "usb_port3")
        image4.image = UIImage(named: "usb_port4")
        hideElements()
        hdmiDescription.isHidden = false
    

        super.viewDidLoad()
    }
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            //view.backgroundColor = .black
            hideElements()
            
            hdmiDescription.isHidden = false
        }
        else if sender.selectedSegmentIndex == 1{
            //view.backgroundColor = .blue
            hideElements()
            image1.image = UIImage(named: "usb_port1")
            image2.image = UIImage(named: "usb_port2")
            image3.image = UIImage(named: "usb_port3")
            image4.image = UIImage(named: "usb_port4")
            showImages()
        }
        else if sender.selectedSegmentIndex == 2{
            //view.backgroundColor = .green
            hideElements()
            image1.image = UIImage(named: "hdmi_device1")
            image2.image = UIImage(named: "hdmi_device2")
            image3.image = UIImage(named: "hdmi_device3")
            image4.image = UIImage(named: "hdmi_device4")
            showImages()
        }
        else if sender.selectedSegmentIndex == 3{
            //view.backgroundColor = .red
            hideElements()
            image1.image = UIImage(named: "usb_port1")
            image2.image = UIImage(named: "usb_port2")
            image3.image = UIImage(named: "usb_port3")
            image4.image = UIImage(named: "usb_port4")
            showImages()
        }
    }
    
    
    func hideElements(){
        hdmiDescription.isHidden = true
        
        image1.isHidden = true
        image2.isHidden = true
        image3.isHidden = true
        image4.isHidden = true
    }
    
    func showImages(){
        image1.isHidden = false
        image2.isHidden = false
        image3.isHidden = false
        image4.isHidden = false
    }
}
