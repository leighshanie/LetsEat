//
//  Device.swift
//  LetsEat
//
//  Created by Xinyi Li on 14/10/2018.
//  Copyright © 2018 shawneeluis. All rights reserved.
//

import UIKit

struct Device {
    
    static var currentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.current
        }
        return Singleton.device
    }
    
    static var isPhone: Bool {
        return currentDevice.userInterfaceIdiom == .phone
    }
    
    static var isPad: Bool {
        return currentDevice.userInterfaceIdiom == .pad
    }
}
