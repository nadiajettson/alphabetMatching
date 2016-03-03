//
//  gameCompleteViewController.swift
//  alphabetMatching
//
//  Created by MacBook on 2/25/16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import UIKit

class gameCompleteViewController: UIViewController{
    
    @IBOutlet weak var animationOutlet: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var animationImages: [UIImage] = []
        
        for i in 1..<9{
            animationImages.append(UIImage(named: "balloon\(i).tiff")!)
        }
        
        animationOutlet.animationImages = animationImages
        animationOutlet.animationDuration = 2.0
        animationOutlet.startAnimating()
        
    
        
       
            //            animationImages.append(UIImage(named: "bee\(i).tiff")!)
    
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
}
