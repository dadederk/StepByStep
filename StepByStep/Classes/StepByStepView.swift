//
//  StepByStepView.swift
//  StepByStepExample
//
//  Created by Daniel Devesa Derksen-Staats on 14/05/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import UIKit

public class StepByStep: UIView {

    public var currentStepIndex: UInt {
        didSet {
            if self.currentStepIndex > self.numberOfSteps {
                self.currentStepIndex = numberOfSteps
            }
            
            updateCurrentStep()
        }
    }
    public var numberOfSteps: UInt {
        didSet {
            self.updateStepByStepView()
        }
    }
    public var stepsSeparation: CGFloat
    public var stepsColor: UIColor
    
    override public init(frame: CGRect) {
        
        self.currentStepIndex = 0
        self.numberOfSteps = 5
        self.stepsSeparation = 5.0
        self.stepsColor = UIColor.orangeColor()
        
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        
        self.updateStepByStepView()
    }
    
    func updateStepByStepView() {
    
        self.removeAllSteps()
        
        if self.numberOfSteps > 0 {
            self.updateSteps()
            self.updateCurrentStep()
        }
    }
    
    func removeAllSteps() {
    
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func updateSteps() {
    
        let separationsWidth = self.stepsSeparation * CGFloat(self.numberOfSteps - 1)
        let stepsWidth = (self.frame.size.width - separationsWidth) / CGFloat(self.numberOfSteps);
        
        for index in 0..<self.numberOfSteps {
            
            let x = CGFloat(index) * (stepsWidth + self.stepsSeparation)
            let stepViewFrame = CGRectMake(x, 0.0, stepsWidth, self.frame.height)
            let stepView = UIView(frame: stepViewFrame)
            
            stepView.backgroundColor = self.stepsColor
            self.addSubview(stepView)
        }
    }
    
    func updateCurrentStep() {
        
        for (index, subview) in self.subviews.enumerate() {
        
            if index < Int(self.currentStepIndex) {
                subview.hidden = true
            } else {
                subview.hidden = false
            }
        }
    }
}