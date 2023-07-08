//
//  Debouncer.swift
//  BCAMusicPlayer
//
//  Created by Ray on 07/07/23.
//

import SwiftUI

struct Debouncer {
    private var timer: Timer?
    
    mutating func debounce(interval: TimeInterval, action: @escaping () -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            action()
        }
    }
}
