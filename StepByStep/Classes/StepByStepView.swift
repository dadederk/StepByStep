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
        if self.numberOfSteps > 0 {
            self.removeUnnecessarySteps()
            self.updateSteps()
            self.updateCurrentStep()
            self.addNecessarySteps()
        }
    }
    
    func removeUnnecessarySteps() {
        if Int(self.numberOfSteps) < self.subviews.count {
            for index in Int(self.numberOfSteps)..<self.subviews.count {
                self.subviews[Int(index)].removeFromSuperview()
            }
        }
    }
    
    func updateSteps() {
        for (index, subview) in self.subviews.enumerate() {
            if index < Int(self.numberOfSteps) {
                UIView.animateWithDuration(0.2, animations: {
                    self.subviews[Int(index)].frame = self.stepFrameForIndex(index)
                })
            } else {
                UIView.animateWithDuration(0.2, animations: {
                    subview.alpha = 0.0
                    }, completion: { (finished) in
                        subview.removeFromSuperview()
                })
            }
        }
    }
    
    func updateCurrentStep() {
        for (index, subview) in self.subviews.enumerate() {
            if index < Int(self.currentStepIndex) {
                UIView.animateWithDuration(0.2, animations: {
                    subview.alpha = 0.0
                })
            } else {
                UIView.animateWithDuration(0.2, animations: {
                    subview.alpha = 1.0
                })
            }
        }
    }
    
    func addNecessarySteps() {
        if Int(self.numberOfSteps) > self.subviews.count {
            for index in self.subviews.count..<Int(self.numberOfSteps) {
                let view = UIView(frame: self.stepFrameForIndex(index))
                view.backgroundColor = self.stepsColor
                view.alpha = 0.0
                
                self.addSubview(view)
                
                UIView.animateWithDuration(0.2, animations: { 
                    view.alpha = 1.0
                })
            }
        }
    }
    
    func stepFrameForIndex(index: Int) -> CGRect {
        let separationsWidth = self.stepsSeparation * CGFloat(self.numberOfSteps - 1)
        let stepsWidth = (self.frame.size.width - separationsWidth) / CGFloat(self.numberOfSteps);
        let x = CGFloat(index) * (stepsWidth + self.stepsSeparation)
        let stepViewFrame = CGRectMake(x, 0.0, stepsWidth, self.frame.height)
        
        return stepViewFrame
    }
}