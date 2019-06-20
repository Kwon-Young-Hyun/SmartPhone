//
//  CustomCell.swift
//  FinalApp
//
//  Created by KPUGAME on 17/06/2019.
//  Copyright © 2019 KwonYoungHyun. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var AddressText: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var starbutton: UIButton!
    
    var audioController : AudioController
    
    let AudioEffectFiles = ["ding.mp3"]
    
    required init?(coder aDecoder: NSCoder) {
        audioController = AudioController()
        audioController.preloadAudioEaffects(audioFileNames: AudioEffectFiles)
        
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func starbuttonpush(_ sender: Any) {
        //print("Bookmark")
        
        let data = UserDefaults.standard.value(forKey: "title")
        var titleArray = [String]()
        if data != nil {
            titleArray = data as! [String]
        }
        titleArray.append(TitleText.text!)
        UserDefaults.standard.set(titleArray, forKey: "title")
        
        let data2 = UserDefaults.standard.value(forKey: "address")
        var addArray = [String]()
        if data2 != nil {
            addArray = data2 as! [String]
        }
        addArray.append(AddressText.text!)
        UserDefaults.standard.set(addArray, forKey: "address")
        
        let particle = ParticleView(frame: CGRect(x: (starbutton.imageView?.center.x)!, y: (starbutton.imageView?.center.y)!, width: 10, height: 10))
        starbutton.imageView?.superview?.addSubview(particle)
        starbutton.imageView?.superview?.sendSubviewToBack(_: particle)
        
        audioController.playerEffect(name: "ding.mp3")
    }
}
