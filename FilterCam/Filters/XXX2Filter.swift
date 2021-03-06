//
//  XXX2Filter.swift
//  FilterCam
//
//  Created by Philip Price on 10/12/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//

import Foundation
import GPUImage


open class XXX2: BasicOperation {
    open var xxx:Float = 0.25 { didSet { uniformSettings["xxx"] = xxx } }
    open var yyy:Float = 0.5 { didSet { uniformSettings["yyy"] = yyy } }
    open var zzz:Position = Position.center { didSet { uniformSettings["zzz"] = zzz } }
    
    public init() {
        super.init(fragmentShader:BulgeDistortionFragmentShader, numberOfInputs:1)
        
        ({xxx = 0.25})()
        ({yyy = 0.5})()
        ({zzz = Position.center})()
    }
}
