//
//  LoadingShowable.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 7.06.2023.
//

import UIKit

protocol LoadingShowable {
    func showLoading()
    func hideLoading()
}

extension LoadingShowable {
    func showLoading() {
        LoadingView.shared.startLoading()
    }

    func hideLoading() {
        LoadingView.shared.hideLoading()
    }
}
