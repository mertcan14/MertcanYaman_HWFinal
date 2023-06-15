//
//  HomePresenterTests.swift
//  MertcanYaman_HW4Tests
//
//  Created by mertcan YAMAN on 15.06.2023.
//

import XCTest
@testable import MertcanYaman_HW4
@testable import MusicAPI

final class HomePresenterTests: XCTestCase {
    
    var presenter: HomePresenter!
    var view: MockHomeViewController!
    var interactor: MockHomeInteractor!
    var router: MockHomeRouter!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view, router, interactor)
    }
    
    override func tearDown() {
        super.tearDown()
        
        view = nil
        interactor = nil
        router = nil
        presenter = nil
    }
    
    func test_viewDidLoad_InvokesRequiredViewMethods() {
        
        XCTAssertFalse(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 0)
        XCTAssertFalse(view.isInvokedSetupField)
        XCTAssertEqual(view.invokedSetupFieldCount, 0)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.isInvokedSetupTableView)
        XCTAssertEqual(view.invokedSetupTableViewCount, 1)
        XCTAssertTrue(view.isInvokedSetupField)
        XCTAssertEqual(view.invokedSetupFieldCount, 1)
        
    }
    
    func test_viewWillAppear_InvokesRequiredViewMethods() {
        
        XCTAssertFalse(view.isInvokedSetWillAppear)
        XCTAssertEqual(view.invokedSetWillAppearCount, 0)
        XCTAssertFalse(view.isInvokedHiddenPlayedSong)
        XCTAssertEqual(view.invokedHiddenPlayedSongCount, 0)
        XCTAssertEqual(view.invokedHiddenPlayedSongParameters?.bool, nil)
        
        presenter.viewWillAppear()
        
        XCTAssertTrue(view.isInvokedSetWillAppear)
        XCTAssertEqual(view.invokedSetWillAppearCount, 1)
        XCTAssertTrue(view.isInvokedHiddenPlayedSong)
        XCTAssertEqual(view.invokedHiddenPlayedSongCount, 1)
        XCTAssertEqual(view.invokedHiddenPlayedSongParameters?.bool, true)
    }
    
    func test_fetchData_InvokesRequiredViewMethods() {
        
        XCTAssertEqual(presenter.numberOfMusics, 0)
        XCTAssertFalse(view.isInvokedReloadData)
        XCTAssertNil(presenter.getMusicByIndex(0))
        
        presenter.getMusics(.response)
        
        XCTAssertEqual(presenter.numberOfMusics, 50)
        XCTAssertTrue(view.isInvokedReloadData)
        XCTAssertNotNil(presenter.getMusicByIndex(1))
    }
    
}

extension MusicResult {
    
    static var response: MusicResult {
        let bundle = Bundle(for: HomePresenterTests.self)
        let path = bundle.path(forResource: "Songs", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! Decoders.dateDecoder.decode(MusicResult.self, from: data)
        return response
    }
}
