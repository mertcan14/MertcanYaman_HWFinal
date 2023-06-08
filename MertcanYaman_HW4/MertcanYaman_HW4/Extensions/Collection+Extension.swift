//
//  Collection+Extension.swift
//  MertcanYaman_HW4
//
//  Created by mertcan YAMAN on 8.06.2023.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    
  subscript (safe index: Index) -> Iterator.Element? {
    return indices.contains(index) ? self[index] : nil
  }
    
}
