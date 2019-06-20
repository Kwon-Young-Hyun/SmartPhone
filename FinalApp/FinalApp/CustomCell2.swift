//
//  CustomCell2.swift
//  FinalApp
//
//  Created by KPUGAME on 17/06/2019.
//  Copyright © 2019 KwonYoungHyun. All rights reserved.
//

import UIKit

class CustomCell2: UITableViewCell {
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var AddText: UILabel!
    @IBOutlet weak var MarkButton: UIButton!
    
    var audioController : AudioController
    
    let AudioEffectFiles = ["ding.mp3"]
    
    required init?(coder aDecoder: NSCoder) {
        audioController = AudioController()
        audioController.preloadAudioEaffects(audioFileNames: AudioEffectFiles)
        
        super.init(coder: aDecoder)
    }
    
    @IBAction func MarkButtonPush(_ sender: Any) {
        print("Mail Bookmark")
        
        let data = UserDefaults.standard.value(forKey: "mailnumber")
        var titleArray = [String]()
        if data != nil {
            titleArray = data as! [String]
        }
        titleArray.append(TitleText.text!)
        UserDefaults.standard.set(titleArray, forKey: "mailnumber")
        
        let data2 = UserDefaults.standard.value(forKey: "mailadd")
        var addArray = [String]()
        if data2 != nil {
            addArray = data2 as! [String]
        }
        addArray.append(AddText.text!)
        UserDefaults.standard.set(addArray, forKey: "mailadd")
        
        let particle = ParticleView(frame: CGRect(x: (MarkButton.imageView?.center.x)!, y: (MarkButton.imageView?.center.y)!, width: 10, height: 10))
        MarkButton.imageView?.superview?.addSubview(particle)
        MarkButton.imageView?.superview?.sendSubviewToBack(_: particle)
        
        audioController.playerEffect(name: "ding.mp3")
    }
}
