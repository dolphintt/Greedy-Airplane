//
//  SoundManager.swift
//  FinalMid
//
//  Created by 小同同 on 4/21/17.
//  Copyright © 2017 小同同. All rights reserved.
//

import UIKit
import AVFoundation
import SpriteKit

class SoundManager: SKNode{
    fileprivate var bgmPlayer: AVAudioPlayer?
    fileprivate var gameOverPlayer: AVAudioPlayer?
    
    override init(){
        super.init()
        self.bgmPlayer = self.makePlayer(name: "bgm", ofType: "mp3")!
        self.bgmPlayer?.numberOfLoops = Int.max
        self.bgmPlayer?.volume = 0.5
        
        self.gameOverPlayer = self.makePlayer(name: "Bomb", ofType: "mp3")!
        self.gameOverPlayer?.volume = 0.8
        
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setCategory(AVAudioSessionCategorySoloAmbient)
        } catch { }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        debugPrint("deinit SoundMagener")
    }
    
    fileprivate func makePlayer(name: String, ofType: String) -> AVAudioPlayer?{
        if let path = Bundle.main.path(forResource: name, ofType: ofType){
            let url = URL(fileURLWithPath: path)
            do {
                return try AVAudioPlayer(contentsOf: url)
            } catch{ }
        }
        return nil
    }
    
    func playBGM(){
        self.bgmPlayer?.play()
    }
    
    func pauseBGM(){
        self.bgmPlayer?.pause()
    }
    
    func resumeBGM(){
        self.bgmPlayer?.prepareToPlay()
        self.bgmPlayer?.play(atTime: self.bgmPlayer!.deviceCurrentTime)
    }
    
    func stopBGM(){
        self.bgmPlayer?.stop()
    }
    
    func gameOver(){
        self.gameOverPlayer?.play()
    }
    
    func crash(){
        run(SKAction.playSoundFileNamed("Ding", waitForCompletion: false))
    }

    func clear(){
        self.bgmPlayer?.stop()
        self.gameOverPlayer?.stop()
    }
}
