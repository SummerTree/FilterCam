//
//  NoFilterDescriptor.swift
//  FilterCam
//
//  Created by Philip Price on 10/4/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//

import Foundation
import GPUImage


class NoFilterDescriptor: FilterDescriptorInterface {
    
    
    let key = "NoFilter"
    let title = "No Filter"
    
    var show: Bool = true
    var rating: Int = 0

    var filter: BasicOperation?  = nil
    let filterGroup: OperationGroup? = nil
    
    let numParameters = 0
    let parameterConfiguration:[ParameterSettings] = []
    
    
    let filterOperationType = FilterOperationType.singleInput
    
    fileprivate var lclFilter:OpacityAdjustment = OpacityAdjustment() // the actual filter
    fileprivate var stash_opacity: Float
    
    
    required init(){
        filter = lclFilter // assign the filter defined in the interface to the instantiated filter of the desired sub-type
        lclFilter.opacity = 1.0
        stash_opacity = lclFilter.opacity
        log.verbose("config: \(parameterConfiguration)")
    }
    
    
    //MARK: - Required funcs
    
    func reset(){
        lclFilter.removeAllTargets()
        lclFilter = OpacityAdjustment()
        restoreParameters()
    }
    
    
    func configureCustomFilter(_ input:(filter:BasicOperation, secondInput:BasicOperation?)){
        // nothing to do
    }
    
    
    
    func getParameter(_ index: Int)->Float {
        switch (index){
        case 1:
            return lclFilter.opacity
        default:
            return parameterNotSet
        }
    }
    
    
    func setParameter(_ index: Int, value: Float) {
        switch (index){
        case 1:
            //lclFilter.opacity = value
            lclFilter.opacity = 1.0
            log.debug("\(parameterConfiguration[0].title):\(value)")
            break
        default:
            log.error("Invalid parameter index (\(index)) for filter: \(key)")
        }
    }
    
    
    
    func getColorParameter(_ index: Int)->UIColor { return UIColor.blue }
    func setColorParameter(_ index:Int, color:UIColor) {}
    
    
    func stashParameters(){
        stash_opacity = lclFilter.opacity
    }
    
    func restoreParameters(){
        lclFilter.opacity = stash_opacity
    }
}
