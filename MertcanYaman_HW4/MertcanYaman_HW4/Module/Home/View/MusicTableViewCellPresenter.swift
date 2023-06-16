//
//  MusicTableViewCellPresenter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 15.06.2023.
//

import Foundation

protocol MusicTableViewCellPresenterProtocol: AnyObject {
    
    func load()
    func playSongTap()
    
}

final class MusicTableViewCellPresenter {
    
    weak var view: MusicTableViewCellProtocol?
    private let music: (URL?,String,String,Int,Int)?
    var index: Int = -1
    var isStartedMusic: Bool = false
    
    init(
        view: MusicTableViewCellProtocol?,
        music: (URL?,String,String,Int,Int)
    ){
        self.view = view
        self.music = music
        self.index = music.3
    }
    
}

extension MusicTableViewCellPresenter: MusicTableViewCellPresenterProtocol {
    
    func playSongTap() {
        
        NotificationCenter.default.post(
            name: Notification.Name("OtherMusicListStarted"),
            object: nil)
        guard let music else { return }
        if !PlaySong.shared.checkPlayedEqualIsThisSong(music.4) {
            PlaySong.shared.startSong(index)
        }else {
            PlaySong.shared.stopSong()
        }
        
    }
    
    func load() {
        
        guard let music,
              let url = music.0 else { return }
        
        view?.setTitle(music.1)
        view?.setImage(url)
        view?.setArtist(music.2)
        if PlaySong.shared.checkPlayedEqualIsThisSong(music.4) {
            isStartedMusic = true
            view?.setButton(true)
        }else {
            isStartedMusic = false
            view?.setButton(false)
        }
        
    }

}
