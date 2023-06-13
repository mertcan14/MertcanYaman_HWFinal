//
//  PlaySong.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 13.06.2023.
//

import Foundation
import AVFoundation

final class PlaySong {
    
    static let shared = PlaySong()
    
    private var songsUrl: [Music] = []
    private var index: Int = 0
    private var player: AVPlayer?
    
    func startSong(_ index: Int) {
        do {
            self.player?.pause()
            guard let previewUrl = songsUrl[safe: index]?.previewURL,
                  let url = URL(string: previewUrl) else { return }
            self.index = index
            let playerItem = AVPlayerItem(url: url)
            
            self.player = try AVPlayer(playerItem:playerItem)
            player!.volume = 1.0
            player!.play()
        }catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
    
    func stopSong() {
        self.player?.pause()
    }
    
    func setUrls(_ urls: [Music]) {
        self.songsUrl = urls
    }
    
    func getNextSong() -> Music?{
        self.index += 1
        if self.index == songsUrl.count {
            self.index = 0
        }
        return self.songsUrl[safe: self.index]
    }
    
}
