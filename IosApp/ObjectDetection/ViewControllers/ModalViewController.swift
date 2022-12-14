//
//  ModalViewController.swift
//  ObjectDetection
//
//  Created by Dimo Popov on 17/01/2022.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

class ModalViewController: UIViewController {
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    
    
    let label = UILabel()
    

    @IBOutlet var hdmiDescription : UILabel!
    
    override func viewDidLoad() {


        hdmiDescription.text = "High-Definition Multimedia Interface (HDMI) \nis a proprietary audio/video interface for \ntransmitting uncompressed video data and \ncompressed or uncompressed digital audio data \nfrom an HDMI-compliant source device, \nsuch as a display controller, to a compatible \ncomputer monitor, video projector, \ndigital television, or digital audio device.[3] \nHDMI is a digital replacement for analog \nvideo standards."
        hdmiDescription.numberOfLines = 0
        hdmiDescription.translatesAutoresizingMaskIntoConstraints = false
        hdmiDescription.lineBreakMode = .byWordWrapping
        
        image1.image = UIImage(named: "hdmi_port1")
        image2.image = UIImage(named: "hdmi_port2")
        image3.image = UIImage(named: "hdmi_port3")
        image4.image = UIImage(named: "hdmi_port4")
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
            image1.image = UIImage(named: "hdmi_port1")
            image2.image = UIImage(named: "hdmi_port2")
            image3.image = UIImage(named: "hdmi_port3")
            image4.image = UIImage(named: "hdmi_port4")
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
            image1.image = UIImage(named: "hdmi_cable1")
            image2.image = UIImage(named: "hdmi_cable2")
            image3.image = UIImage(named: "hdmi_cable3")
            image4.image = UIImage(named: "hdmi_cable4")
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
