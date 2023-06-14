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
    private var index: Int = -1
    private var player: AVPlayer?
    private var playedSong: Bool = false
    
    func startSong(_ index: Int) {
        self.player?.pause()
        guard let previewUrl = songsUrl[safe: index]?.previewURL,
              let url = URL(string: previewUrl) else { return }
        self.index = index
        let playerItem = AVPlayerItem(url: url)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        self.player = AVPlayer(playerItem:playerItem)
        player!.volume = 1.0
        player!.play()
        playedSong = true
        
        guard let music = getMusicForTableCellByIndex() else { return }
        NotificationCenter.default.post(name: Notification.Name("PlayedSong"), object: nil)
    }
    
    func getMusicForTableCellByIndex() -> (String, String)? {
        guard let music = self.songsUrl[safe: index],
              let imageUrl = music.artworkUrl100,
              let title = music.trackName else { return nil }
        return (imageUrl, title)
    }
    
    func stopSong() {
        self.player?.pause()
        playedSong = false
        NotificationCenter.default.post(name: Notification.Name("StopSong"), object: nil)
    }
    
    func setUrls(_ urls: [Music]) {
        
        self.songsUrl = urls
        if urls.count == 1 {
            self.songsUrl += urls
        }
        
    }
    
    func getNextSong(_ index: Int) -> Music?{
        self.index = index + 1
        if self.index == songsUrl.count {
            self.index = 0
        }
        return self.songsUrl[safe: self.index]
    }
    
    func goNextSong(_ index: Int) {
        self.index = index + 1
        if self.index == songsUrl.count {
            self.index = 0
        }
        self.startSong(self.index)
    }
    
    func getPreviousSong(_ index: Int) -> Music?{
        self.index = index - 1
        if self.index < 0 {
            self.index = self.songsUrl.count - 1
        }
        return self.songsUrl[safe: self.index]
    }
    
    func goPreviousSong(_ index: Int) {
        self.index = index - 1
        if self.index < 0 {
            self.index = self.songsUrl.count - 1
        }
        self.startSong(self.index)
    }
    
    func checkPlayedEqualIsThisSong(_ trackId: Int) -> Bool {
        guard let playedTrackId = self.songsUrl[safe: self.index]?.trackID else { return false }
        if playedSong {
            return playedTrackId == trackId
        }
        return false
    }
    
    func isPlay() -> Bool{
        playedSong
    }
    
    func getIndex() -> Int{
        index
    }
    
    func isEmpty() -> Bool {
        self.songsUrl.isEmpty
    }
    
    @objc func playerDidFinishPlaying() {
        goNextSong(self.index)
    }
}
