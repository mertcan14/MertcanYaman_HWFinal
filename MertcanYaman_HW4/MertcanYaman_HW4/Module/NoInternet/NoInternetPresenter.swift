//
//  NoInternetPresenter.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import Foundation

protocol NoInternetPresenterProtocol: AnyObject {
    func checkInternetConnection()
}

final class NoInternetPresenter: NoInternetPresenterProtocol {
    
    unowned var view: NoInternetViewControllerProtocol
    let router: NoInternetRouterProtocol
    let interactor: NoInternetInteractorProtocol
    var timeWaitStarter: Int = 5
    var timeWait: Int = 5
    var timer : Timer?
    
    init(
        _ view: NoInternetViewControllerProtocol,
        _ router: NoInternetRouterProtocol,
        _ interactor: NoInternetInteractorProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    func checkInternetConnection() {
        interactor.checkInternetConnection()
    }
    
    private func timeString(_ time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    private func runTimer() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
      timer?.invalidate()
      timer = nil
    }
    
    @objc func updateTimer() {
        if timeWait != 0 {
            timeWait -= 1
            self.view.setTimeLabel(self.timeString(TimeInterval(timeWait)))
        }else {
            self.view.enabledBtn(true)
            self.view.hiddenTimeLabel()
            self.stopTimer()
        }
    }
    
}

extension NoInternetPresenter: NoInternetInteractorOutputProtocol {
    
    func internetConnection(_ status: Bool) {
        self.view.hideLoading()
        if status {
            router.navigate(.homeScreen)
        }else {
            timeWait = timeWaitStarter
            self.view.setTimeLabel(self.timeString(TimeInterval(timeWait)))
            self.view.showTimeLabel()
            self.view.enabledBtn(false)
            self.runTimer()
            if timeWaitStarter < 90 {
                self.timeWaitStarter += 10
            }
        }
    }
    
}
