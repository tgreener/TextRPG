//
//  Generator.swift
//  TextRPG
//
//  Created by Todd Greener on 6/9/15.
//  Copyright (c) 2015 Todd Greener. All rights reserved.
//

import Foundation

protocol GeneratorListener {
    func onGenerated(#entity: Entity) -> Void
}

protocol Generator : WorldClockListener {
    var generationTimeRange : TimeRange { get }
    func addListener(listener: GeneratorListener) -> Void
}

func defaultGenerationProbabilityFunction (durationInRange : WorldTime, range : WorldTime) -> Bool {
    let p : Int = Int((durationInRange / range) * 99 as Double)
    let result : Int = Int(arc4random_uniform(100))
    return p >= result
}

class GeneratorComponent : Generator {
    let generationTimeRange : TimeRange
    let generationFunction : () -> Entity?
    let notifier : Notifier<GeneratorListener> = Notifier<GeneratorListener>()
    var timeSinceLastGeneration : WorldTime = TimeDefs.zeroTime
    
    var generationProbabilityFunction : (durationInRange : WorldTime, range : WorldTime) -> Bool
    
    init(timeRange : TimeRange, generationFunction : () -> Entity?) {
        self.generationProbabilityFunction = defaultGenerationProbabilityFunction
        self.generationTimeRange = timeRange
        self.generationFunction = generationFunction
    }
    
    func worldClockDidProgress(by dt: WorldTime, currentTime : WorldTime) {
        timeSinceLastGeneration += dt
        
        // Only bother if the minimum amount of time has passed
        if timeSinceLastGeneration >= generationTimeRange.minTime {
            let durationInRange = timeSinceLastGeneration - generationTimeRange.minTime
            
            // If the amount of time passed is the maximum amount of time to go between generations
            if durationInRange >= generationTimeRange.range {
                runGenerationFunction()
                return
            }
            
            // Use the probability function to determine whether or not something was generated
            let generated = self.generationProbabilityFunction(durationInRange: durationInRange, range: generationTimeRange.range)
            if generated { runGenerationFunction() }
        }
    }
    
    func addListener(listener: GeneratorListener) {
        notifier.addListener(listener)
    }
    
    func runGenerationFunction() {
        if let e = self.generationFunction() {
            notifier.notify { listener in listener.onGenerated(entity: e) }
        }
        timeSinceLastGeneration = 0
    }
}
