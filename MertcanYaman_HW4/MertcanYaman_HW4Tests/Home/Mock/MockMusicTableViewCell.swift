//
//  MockMusicTableViewCell.swift
//  MertcanYaman_HW4Tests
//
//  Created by mertcan YAMAN on 15.06.2023.
//

import Foundation
@testable import MertcanYaman_HW4

final class MockMusicTableViewCell: MusicTableViewCellProtocol {
    
    var isInvokedSetImage = false
    var invokedSetImageCount = 0
    
    func setImage(_ image: URL) {
        self.isInvokedSetImage = true
        self.invokedSetImageCount += 1
    }
    
    var isInvokedSetTitle = false
    var invokedSetTitleCount = 0
    
    func setTitle(_ text: String) {
        self.isInvokedSetTitle = true
        self.invokedSetTitleCount += 1
    }
    
    var isInvokedSetArtist = false
    var invokedSetArtistCount = 0
    
    func setArtist(_ text: String) {
        self.isInvokedSetArtist = true
        self.invokedSetArtistCount += 1
    }
    
    var isInvokedSetButton = false
    var invokedSetButtonCount = 0
    
    func setButton(_ bool: Bool) {
        self.isInvokedSetButton = true
        self.invokedSetButtonCount += 1
    }
    
}
