//
//  MusicTableViewCellPresenterTests.swift
//  MertcanYaman_HW4Tests
//
//  Created by mertcan YAMAN on 15.06.2023.
//

import XCTest
@testable import MertcanYaman_HW4

final class MusicTableViewCellPresenterTests: XCTestCase {

    var view: MockMusicTableViewCell!
    var music: (URL?,String,String,Int,Int)!
    var presenter: MusicTableViewCellPresenter!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        self.music = (
            URL(string: "https://is1-ssl.mzstatic.com/image/thumb/Music3/v4/45/f3/0a/45f30a22-3a12-66b8-21a2-d21386af084f/cover.jpg/100x100bb.jpg"),
            "Yolla",
            "Tarkan",
            1,
            141414
        )
        presenter = .init(view: view, music: self.music)
        
    }
    
    override func tearDown() {
        view = nil
        presenter = nil
        music = nil
    }
    
    func test_load() {
        
        XCTAssertFalse(view.isInvokedSetImage)
        XCTAssertEqual(view.invokedSetImageCount, 0)
        XCTAssertFalse(view.isInvokedSetTitle)
        XCTAssertEqual(view.invokedSetTitleCount, 0)
        XCTAssertFalse(view.isInvokedSetArtist)
        XCTAssertEqual(view.invokedSetArtistCount, 0)
        XCTAssertFalse(view.isInvokedSetButton)
        XCTAssertEqual(view.invokedSetButtonCount, 0)
        
        presenter.load()
        
        XCTAssertTrue(view.isInvokedSetImage)
        XCTAssertEqual(view.invokedSetImageCount, 1)
        XCTAssertTrue(view.isInvokedSetTitle)
        XCTAssertEqual(view.invokedSetTitleCount, 1)
        XCTAssertTrue(view.isInvokedSetArtist)
        XCTAssertEqual(view.invokedSetArtistCount, 1)
        XCTAssertTrue(view.isInvokedSetButton)
        XCTAssertEqual(view.invokedSetButtonCount, 1)
    }
    
}
