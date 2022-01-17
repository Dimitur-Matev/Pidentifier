//
//  ModalViewController.swift
//  ObjectDetection
//
//  Created by Dimo Popov on 17/01/2022.
//  Copyright © 2022 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

class ModalViewController: UIViewController{
    let label = UILabel()
    
    override func viewDidLoad() {
        label.text = "High-Definition Multimedia Interface (HDMI) is a proprietary audio/video interface for transmitting uncompressed video data and compressed or uncompressed digital audio data from an HDMI-compliant source device, such as a display controller, to a compatible computer monitor, video projector, digital television, or digital audio device.[3] HDMI is a digital replacement for analog video standards."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        view.addSubview(label)

        super.viewDidLoad()
    }
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            view.backgroundColor = .black
        }
        else if sender.selectedSegmentIndex == 1{
            view.backgroundColor = .blue

        }
        else if sender.selectedSegmentIndex == 2{
            view.backgroundColor = .green

        }
        else if sender.selectedSegmentIndex == 3{
            view.backgroundColor = .red

        }
    }
}
