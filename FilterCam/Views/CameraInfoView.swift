//
//  CameraInfoView.swift
//  Philter
//
//  Created by Philip Price on 9/16/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//

import UIKit
import Neon


// Class responsible for laying out the Camera Information View
// This is a container class for display the overlay that provides information about the current Camera/Image view

// Interface required of controlling View
protocol CameraInfoViewDelegate: class {
    func filterPressed()
}


class CameraInfoView: UIView {
    
    var isLandscape : Bool = false
    
    // display items
    var currFilter: UIButton! = UIButton()
    var currISO: UIButton! = UIButton()
    var currSpeed: UIButton! = UIButton()
    var currWB: UIButton! = UIButton()
    
    var initDone: Bool = false
   
    
    // delegate for handling events
    weak var delegate: CameraInfoViewDelegate?

    
    
    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    
    func initViews(){
        
        if (!initDone){
            // set the colors etc.
            //self.backgroundColor = UIColor.clear
            //self.isOpaque = false
            self.backgroundColor = UIColor.flatBlack()
            //self.alpha = 0.8
            
            initButton(currFilter)
            initButton(currISO)
            initButton(currSpeed)
            initButton(currWB)

            
            // dummy datat for now
            setFilterName("(no filter)")
            currISO.setTitle("ISO: ?", for: .normal)
            currSpeed.setTitle("Speed: ?", for: .normal)
            currWB.setTitle("WB: ?", for: .normal)
            
            // show the sub views
            self.addSubview(currFilter)
            self.addSubview(currISO)
            self.addSubview(currSpeed)
            self.addSubview(currWB)
            
            //TOFIX: temp, just to show something. Replace with individual overlay classes/views
            //currFilter.anchorInCorner(.bottomLeft, xPad: 2, yPad: 2, width: 128, height: 32)
            initDone = true
        }
    }

    
    func initButton(_ button: UIButton){
        button.backgroundColor = UIColor.clear
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .left
        //button.frame.height = 32
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // get orientation
        //isLandscape = UIDevice.current.orientation.isLandscape

        if !initDone {
            initViews()
        }
        
        self.groupAndFill(.horizontal, views: [currFilter, currISO, currSpeed, currWB], padding: 8)
        
        // TODO: update current values and histogram
        currISO.setTitle("ISO: \(CameraManager.getCurrentISO())", for: .normal)
        currSpeed.setTitle("Speed: \(CameraManager.getCurrentSpeed())", for: .normal)
        
        // register handler for the filter button
        currFilter.addTarget(self, action: #selector(self.filterDidPress), for: .touchUpInside)
      
    }
    
    
    func setFilterName(_ name:String){
        currFilter.setTitle(name, for: .normal)
    }
    
    //MARK: - touch handlers
    
    func filterDidPress() {
        delegate?.filterPressed()
    }
    
}
