//
//  MockHomeViewController.swift
//  MertcanYaman_HW4Tests
//
//  Created by mertcan YAMAN on 15.06.2023.
//

import Foundation
@testable import MertcanYaman_HW4

final class MockHomeViewController: HomeViewControllerProtocol {
    
    var isInvokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadData() {
        self.isInvokedReloadData = true
        self.invokedReloadDataCount += 1
    }
    
    var isInvokedSetupField = false
    var invokedSetupFieldCount = 0
    
    func setupField() {
        self.isInvokedSetupField = true
        self.invokedSetupFieldCount += 1
    }
    
    var isInvokedSetupTableView = false
    var invokedSetupTableViewCount = 0
    
    func setupTableView() {
        self.isInvokedSetupTableView = true
        self.invokedSetupTableViewCount += 1
    }
    
    var isInvokedSetWillAppear = false
    var invokedSetWillAppearCount = 0
    
    func setWillAppear() {
        self.isInvokedSetWillAppear = true
        self.invokedSetWillAppearCount += 1
    }
    
    var isInvokedHiddenPlayedSong = false
    var invokedHiddenPlayedSongCount = 0
    var invokedHiddenPlayedSongParameters: (bool:Bool, Void)?
    
    func hiddenPlayedSong(_ bool: Bool) {
        self.isInvokedHiddenPlayedSong = true
        self.invokedHiddenPlayedSongCount += 1
        self.invokedHiddenPlayedSongParameters = (bool, ())
    }
    
    var isInvokedReloadDataNotification = false
    var invokedReloadDataNotificationCount = 0
    
    func reloadDataNotification() {
        self.isInvokedReloadDataNotification = true
        self.invokedReloadDataNotificationCount = 1
    }
    
    var isInvokedShowAlert = false
    var invokedShowAlertCount = 0
    var invokedShowAlertParameters: (title:String, message:String, Void)?
    
    func showAlert(_ title: String, _ message: String, _ action: (() -> Void)?) {
        self.isInvokedShowAlert = true
        self.invokedShowAlertCount = 1
        self.invokedShowAlertParameters = (title, message, ())
    }
    
    
}
