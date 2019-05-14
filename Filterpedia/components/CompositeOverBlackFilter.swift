//
//  CompositeOverBlackFilter.swift
//  Filterpedia
//
//  Created by Simon Gladman on 01/01/2016.
//  Copyright © 2016 Simon Gladman. All rights reserved.
//

import UIKit
import CoreImage

class CompositeOverColorFilter: CIFilter
{
    let color: CIFilter
    let composite: CIFilter
    
    @objc var inputImage : CIImage?
    
    override init()
    {
        color = CIFilter(name: "CIConstantColorGenerator",
                         parameters: [kCIInputColorKey: CIColor(color: UIColor.black)])!
        
        composite = CIFilter(name: "CISourceAtopCompositing",
                             parameters: [kCIInputBackgroundImageKey: color.outputImage!])!
        
        super.init()
    }
    
    init(_ uiColor: UIColor) {
        color = CIFilter(name: "CIConstantColorGenerator",
                         parameters: [kCIInputColorKey: CIColor(color: uiColor)])!
        
        composite = CIFilter(name: "CISourceAtopCompositing",
                             parameters: [kCIInputBackgroundImageKey: color.outputImage!])!
        
        super.init()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var outputImage: CIImage!
    {
        guard let inputImage = inputImage else
        {
            return nil
        }
        
        composite.setValue(inputImage, forKey: kCIInputImageKey)
        
        return composite.outputImage
    }
}
