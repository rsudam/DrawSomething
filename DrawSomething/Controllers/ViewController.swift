//
//  ViewController.swift
//  DrawSomething
//
//  Created by Raghu Sairam on 17/01/19.
//  Copyright © 2019 Raghu Sairam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let canvas = Canvas()
    
    let undoButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleChange), for: .touchUpInside)
        return button
    }()
    
    let clearButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleChange), for: .touchUpInside)
        return button
    }()
    
    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleChangeColor), for: .touchUpInside)
        return button
    }()
    
    let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleChangeColor), for: .touchUpInside)
        return button
    }()
    
    let greenButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleChangeColor), for: .touchUpInside)
        return button
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleChangeLineWidth), for: .touchUpInside)
        return slider
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    override func loadView() {
        self.view = canvas
    }
    
    
    fileprivate func setupLayout() {
        canvas.backgroundColor = .white
        
        let colorsStackView = UIStackView(arrangedSubviews: [
                redButton,
                blueButton,
                greenButton
        ])
        colorsStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [
            undoButton,
            clearButton,
            colorsStackView,
            slider
        ])
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    @objc fileprivate func handleChange(button: UIButton) {
        if button == clearButton {
            canvas.clear()
        } else {
            canvas.undo()
        }
    }

    @objc fileprivate func handleChangeColor(button: UIButton) {
        if button == redButton {
            canvas.setStrokeColor(color: UIColor.red)
        } else if button == greenButton {
            canvas.setStrokeColor(color: UIColor.green)
        } else {
            canvas.setStrokeColor(color: UIColor.blue)
        }
    }
    
    @objc fileprivate func handleChangeLineWidth(slider: UISlider) {
        canvas.setStrokeWidth(width: CGFloat(slider.value))
    }
}

