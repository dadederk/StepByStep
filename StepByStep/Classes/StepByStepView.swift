//
//  StepByStepView.swift
//  StepByStepExample
//
//  Created by Daniel Devesa Derksen-Staats on 14/05/2016.
//  Copyright © 2016 Desfici. All rights reserved.
//

import UIKit

/// Simple and customisable stepped progress bar UI component
public class StepByStep: UIView {

    /// The current step within the total progress bar's number of steps
    public var currentStepIndex: UInt {
        didSet {
            if self.currentStepIndex > self.numberOfSteps {
                self.currentStepIndex = numberOfSteps
            }
            
            updateCurrentStep()
        }
    }
    /// The total number of steps in the progress bar
    public var numberOfSteps: UInt {
        didSet {
            self.updateStepByStepView()
        }
    }
    /// The separation between steps of the progress bar
    public var stepsSeparation: CGFloat
    /// The colour of the non completed steps in the progress bar
    public var stepsColor: UIColor
    
    /**
        Initialises a new StepByStep view with a given frame and with other default values:
        5 orange steps, non of them completed and a separation of 5.0 points between them
     
        - Parameter frame: The frame with the size and position of the view
     
        - Returns: An initialised StepByStep view component
     */
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
    
    /**
        Updates the progress bar by removing or adding steps if the number of steps
        changed and by updating their position and sizes if necessary, as well as
        hiding the completed steps of the progress bar
     */
    func updateStepByStepView() {
        if self.numberOfSteps > 0 {
            self.removeUnnecessarySteps()
            self.addNecessarySteps()
            self.updateStepsPositionAndSize()
            self.updateCurrentStep()
        }
    }
    
    /**
        Removes any step views over the configured number of steps as that means that
        the configured number of steps changed and those are no longer necessary
     */
    func removeUnnecessarySteps() {
        if Int(self.numberOfSteps) < self.subviews.count {
            for index in (Int(self.numberOfSteps)..<self.subviews.count).reverse() {
                self.subviews[Int(index)].removeFromSuperview()
            }
        }
    }
    
    /**
        Adds as many step views as necessary to match the number of configured steps
     */
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
    
    /**
        Updates the position and size of the step views based on the frame of the
        view, the number of steps and their separation
     */
    func updateStepsPositionAndSize() {
        for index in 0..<Int(self.numberOfSteps) {
            UIView.animateWithDuration(0.2, animations: {
                self.subviews[Int(index)].frame = self.stepFrameForIndex(index)
            })
        }
    }
    
    /**
        Hides the step views below the current step configured index and shows the
        step views above the index with a corresponding fade out/in animation
     */
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
    
    // MARK: Helper methods
    
    /**
        Calculates the frame of a step view in a given position
     
        - Parameter index: The position of the step view
     
        - Returns: The rect of the step view
     */
    func stepFrameForIndex(index: Int) -> CGRect {
        let separationsWidth = self.stepsSeparation * CGFloat(self.numberOfSteps - 1)
        let stepsWidth = (self.frame.size.width - separationsWidth) / CGFloat(self.numberOfSteps);
        let x = CGFloat(index) * (stepsWidth + self.stepsSeparation)
        let stepViewFrame = CGRectMake(x, 0.0, stepsWidth, self.frame.height)
        
        return stepViewFrame
    }
}