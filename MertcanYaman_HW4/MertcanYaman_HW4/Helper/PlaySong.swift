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
    
    // MARK: - Variable Definitions
    private var songs: [Music] = []
    private var index: Int = -1
    private var player: AVPlayer?
    private var playedSong: Bool = false
    
    // MARK: - AvPlayer play func
    func startSong(_ index: Int) {
        
        self.player?.pause()
        
        guard let previewUrl = songs[safe: index]?.previewURL,
              let url = URL(string: previewUrl) else { return }
        self.index = index
        let playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer( playerItem: playerItem)
        player?.volume = 1
        player?.play()
        playedSong = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinishPlaying),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: playerItem)
        NotificationCenter.default.post(name: Notification.Name("PlayedSong"), object: nil)
        
    }
    
    // MARK: - Return information of playing music
    func getMusicForTableCellByIndex() -> (String, String)? {
        
        guard let music = self.songs[safe: index],
              let imageUrl = music.artworkUrl100,
              let title = music.trackName else { return nil }
        return (imageUrl, title)
        
    }
    
    // MARK: - Stop Songs
    func stopSong() {
        
        self.player?.pause()
        playedSong = false
        NotificationCenter.default.post(name: Notification.Name("StopSong"), object: nil)
        
    }
    
    // MARK: - Set Songs
    func setMusics(_ urls: [Music]) {
        
        self.songs = urls
        if urls.count == 1 {
            self.songs += urls
        }
        
    }
    
    // MARK: - Return Next Song
    func getNextSong(_ index: Int) -> Music?{
        
        self.index = index + 1
        if self.index == songs.count {
            self.index = 0
        }
        return self.songs[safe: self.index]
        
    }
    
    // MARK: - Play Next Song
    func goNextSong(_ index: Int) {
        
        self.index = index + 1
        if self.index == songs.count {
            self.index = 0
        }
        self.startSong(self.index)
        
    }
    
    // MARK: - Return Previous Song
    func getPreviousSong(_ index: Int) -> Music?{
        
        self.index = index - 1
        if self.index < 0 {
            self.index = self.songs.count - 1
        }
        return self.songs[safe: self.index]
        
    }
    
    // MARK: - Play Previous Song
    func goPreviousSong(_ index: Int) {
        
        self.index = index - 1
        if self.index < 0 {
            self.index = self.songs.count - 1
        }
        self.startSong(self.index)
        
    }
    
    // MARK: - Return check is the song playing the same as the song playing
    func checkPlayedEqualIsThisSong(_ trackId: Int) -> Bool {
        
        guard let playedTrackId = self.songs[safe: self.index]?.trackID else { return false }
        if playedSong {
            return playedTrackId == trackId
        }
        return false
        
    }
    
    // MARK: - Return is Play
    func isPlay() -> Bool{
        playedSong
    }
    
    // MARK: - Return get Index
    func getIndex() -> Int{
        index
    }
    
    // MARK: - Return get Index
    func isEmpty() -> Bool {
        self.songs.isEmpty
    }
    
    // MARK: - Return get Index
    @objc func playerDidFinishPlaying() {
        goNextSong(self.index)
    }
    
}
