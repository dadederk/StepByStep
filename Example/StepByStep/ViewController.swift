//
//  ViewController.swift
//  StepByStep
//
//  Created by Daniel Devesa Derksen-Staats on 05/15/2016.
//  Copyright (c) 2016 Daniel Devesa Derksen-Staats. All rights reserved.
//

import UIKit
import StepByStep

class ViewController: UIViewController {
    
    @IBOutlet weak var numberOfStepsLabel: UILabel!
    @IBOutlet weak var currentStepLabel: UILabel!
    @IBOutlet weak var numberOfStepsStepper: UIStepper!
    @IBOutlet weak var currentStepStepper: UIStepper!
    
    var stepByStepView: StepByStep!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let stepByStepHeight: CGFloat = 10.0
        let stepByStepViewFrame = CGRectMake(0, self.view.frame.height - stepByStepHeight, self.view.frame.width, stepByStepHeight)
        self.stepByStepView = StepByStep(frame: stepByStepViewFrame)
        self.view.addSubview(self.stepByStepView)
        
        self.numberOfStepsStepper.value = 6
        self.updateNumberOfSteps(UInt(self.numberOfStepsStepper.value))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func stepperValueChanged(sender: AnyObject) {
        
        if let stepper = sender as? UIStepper {
            
            let stepperValue = UInt(stepper.value)
            
            if stepper == self.numberOfStepsStepper {
                self.updateNumberOfSteps(stepperValue)
            } else if stepper == self.currentStepStepper {
                self.updateCurrentStep(UInt(self.currentStepStepper.value))
            }
        }
    }
    
    // MARK: Private
    
    func updateNumberOfSteps(numberOfSteps: UInt) {
        
        self.numberOfStepsLabel.text = "\(numberOfSteps)"
        self.stepByStepView.numberOfSteps = numberOfSteps
        
        if numberOfSteps < UInt(self.currentStepStepper.value) {
            updateCurrentStep(numberOfSteps)
        }
        
        self.currentStepStepper.maximumValue = Double(numberOfSteps)
    }
    
    func updateCurrentStep(currentStep: UInt) {
        
        self.stepByStepView.currentStepIndex = currentStep
        self.currentStepLabel.text = "\(currentStep)"
    }
}