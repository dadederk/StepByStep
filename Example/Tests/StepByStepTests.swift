import UIKit
import XCTest
import StepByStep

class StepByStepTests: XCTestCase {
    
    var stepByStepView: StepByStep!
    
    override func setUp() {
        super.setUp()

        self.stepByStepView = StepByStep(frame: CGRectZero)
    }
    
    override func tearDown() {

        self.stepByStepView = nil
        
        super.tearDown()
    }
    
    func test_updatesNumberOfSteps() {

        var expectedNumberOfSteps: UInt = 7
        self.stepByStepView.numberOfSteps = expectedNumberOfSteps
        
        XCTAssertEqual(self.stepByStepView.subviews.count, Int(expectedNumberOfSteps), "Should have \(expectedNumberOfSteps) steps")
        
        expectedNumberOfSteps = 3
        self.stepByStepView.numberOfSteps = expectedNumberOfSteps
        XCTAssertEqual(self.stepByStepView.subviews.count, Int(expectedNumberOfSteps), "Should have \(expectedNumberOfSteps) steps")
        
        expectedNumberOfSteps = 9
        self.stepByStepView.numberOfSteps = expectedNumberOfSteps
        XCTAssertEqual(self.stepByStepView.subviews.count, Int(expectedNumberOfSteps), "Should have \(expectedNumberOfSteps) steps")
    }
    
    func test_stepIndexSet() {
    
        let expectedCurrentStepIndex: UInt = 2
        self.stepByStepView.currentStepIndex = 5
        self.stepByStepView.currentStepIndex = expectedCurrentStepIndex
        
        XCTAssertEqual(self.stepByStepView.currentStepIndex, expectedCurrentStepIndex, "Current step index not properly assigned")
    }
    
    func test_currentIndexIsNeverHigherThanNumberOfSteps() {

        self.stepByStepView.numberOfSteps = 6
        self.stepByStepView.currentStepIndex = 8
        
        XCTAssertEqual(self.stepByStepView.currentStepIndex, self.stepByStepView.numberOfSteps, "The current step index cannot be higher than the number of steps")
    }
    
    func test_currentStepIndexHidesPreviousStepViews() {
    
        self.stepByStepView.numberOfSteps = 5
        self.stepByStepView.currentStepIndex = 2
        
        XCTAssertEqual(self.stepByStepView.subviews[0].alpha, 0.0)
        XCTAssertEqual(self.stepByStepView.subviews[1].alpha, 0.0)
        XCTAssertEqual(self.stepByStepView.subviews[2].alpha, 1.0)
    }
    
    func test_stepsColorSet() {
    
        let expectedColor = UIColor.redColor()
        self.stepByStepView.stepsColor = expectedColor
        
        XCTAssertEqual(self.stepByStepView.stepsColor, expectedColor, "The colour of the steps has not been properly assigned")
    }
    
    func test_stepsSeparationSet() {
    
        let expectedSeparation: CGFloat = 1.0
        self.stepByStepView.stepsSeparation = expectedSeparation
        
        XCTAssertEqual(self.stepByStepView.stepsSeparation, expectedSeparation, "The separation between steps has not been properly assigned")
    }
}
