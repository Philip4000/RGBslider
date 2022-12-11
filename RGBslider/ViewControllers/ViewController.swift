//
//  ViewController.swift
//  RGBslider
//
//  Created by Philip Noskov on 22.11.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15

        setupLabels(for: redLabel, greenLabel, blueLabel)
        setupColorView()
        
    }
    
    // MARK: - IBActions
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        switch sender.tag {
        case 1: redLabel.text = string(from: sender)
        case 2: greenLabel.text = string(from: sender)
        default: blueLabel.text = string(from: sender)
        }
        setupColorView()
    }
    
    // MARK: - Private Methods
    private func setupLabels(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel: label.text = string(from: redSlider)
            case greenLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
       
    }
    
    private func setupColorView() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
            )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }

}

