//
//  HazeDescriptor.swift
//  FilterCam
//
//  Created by Philip Price on 10/4/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//

import Foundation
import GPUImage


class HazeDescriptor: FilterDescriptorInterface {
    
    
    let key = "Haze"
    let title = "Haze / UV"
    
    var filter: BasicOperation?  = nil
    let filterGroup: OperationGroup? = nil
    
    let numParameters = 1
    let parameterConfiguration = [ParameterSettings(title:"distance", minimumValue:-0.2, maximumValue:0.2, initialValue:0.1, isRGB:false)]
    
    
    let filterOperationType = FilterOperationType.singleInput
    
    private var lclFilter:Haze = Haze() // the actual filter
    private var stash_distance: Float
    
    
    init(){
        filter = lclFilter // assign the filter defined in the interface to the instantiated filter of the desired sub-type
        lclFilter.distance = parameterConfiguration[0].initialValue
        stash_distance = lclFilter.distance
        log.verbose("config: \(parameterConfiguration)")
    }
    
    
    //MARK: - Required funcs
    
    func configureCustomFilter(_ input:(filter:BasicOperation, secondInput:BasicOperation?)){
        // nothing to do
    }
    
    
    
    func getParameter(index: Int)->Float {
        switch (index){
        case 1:
            return lclFilter.distance
        default:
            return parameterNotSet
        }
    }
    
    
    func setParameter(index: Int, value: Float) {
        switch (index){
        case 1:
            lclFilter.distance = value
            log.debug("\(parameterConfiguration[0].title):\(value)")
            break
        default:
            log.error("Invalid parameter index (\(index)) for filter: \(key)")
        }
    }
    
    
    
    func getColorParameter(index: Int)->UIColor { return UIColor.blue }
    func setColorParameter(index:Int, color:UIColor) {}
    
    
    func stashParameters(){
        stash_distance = lclFilter.distance
    }
    
    func restoreParameters(){
        lclFilter.distance = stash_distance
    }
}
