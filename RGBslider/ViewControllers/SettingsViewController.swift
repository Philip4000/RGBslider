//
//  SettingsViewController.swift
//  RGBslider
//
//  Created by Philip Noskov on 22.11.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    var delegate: SettingsViewControllerDelegate!
    var color: UIColor!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = color
        
        setupUI()
        
    }
    
    // MARK: - IBActions
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            redLabel.text = string(from: sender)
            redTF.text = string(from: sender)
        case 2:
            greenLabel.text = string(from: sender)
            greenTF.text = string(from: sender)
        default:
            blueLabel.text = string(from: sender)
            blueTF.text = string(from: sender)
        }
        setupColorView()
    }
    
    @IBAction func saveButtonPressed() {
        delegate.setColor(from: colorView)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        setupTextLabels(for: redLabel, greenLabel, blueLabel, and: redTF, greenTF, blueTF)
    
    }
    
    private func setupTextLabels(for labels: UILabel..., and textFields: UITextField...) {
        labels.forEach { label in
            switch label {
            case redLabel: label.text = string(from: redSlider)
            case greenLabel: label.text = string(from: greenSlider)
            default: label.text = string(from: blueSlider)
            }
        }
        
        textFields.forEach { textField in
            switch textField {
            case redTF: textField.text = string(from: redSlider)
            case greenTF: textField.text = string(from: greenSlider)
            default: textField.text = string(from: blueSlider)
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

