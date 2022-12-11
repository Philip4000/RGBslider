//
//  ColorScreenViewController.swift
//  RGBslider
//
//  Created by Philip Noskov on 11.12.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(from view: UIView)
}

class ColorScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.7, green: 0.5, blue: 0.2, alpha: 1)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }


}

extension ColorScreenViewController: SettingsViewControllerDelegate {
    func setColor(from view: UIView) {
        self.view.backgroundColor = view.backgroundColor
    }
}


