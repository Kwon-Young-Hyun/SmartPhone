//  AudioController.swift
//  Anagrams
//
//  Created by KPUGAME on 23/05/2019.
//  Copyright © 2019 Caroline. All rights reserved.
//

import AVFoundation

class AudioController {
    
    private var audio = [String: AVAudioPlayer]()
    
    let AudioEffectFiles = ["ding.mp3"]
    
    var player: AVAudioPlayer?
    
    func preloadAudioEaffects(audioFileNames: [String]) {
        for effect in AudioEffectFiles {
            let soundPath = Bundle.main.path(forResource: effect, ofType: nil)
            let soundURL = NSURL.fileURL(withPath: soundPath!)
            
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                guard let player = player else {
                    return
                }
                player.numberOfLoops = 0
                player.prepareToPlay()
                audio[effect] = player
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func playerEffect(name: String) {
        if let player = audio[name] {
            if player.isPlaying {
                player.currentTime = 0
            } else {
                player.play()
            }
        }
    }
}
