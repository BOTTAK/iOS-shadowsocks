import Foundation
import UIKit

enum Device {
    case iPhone7
    case iPhone7Plus
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXS
    case iPhoneXSMax
    case iPhoneXR
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax
    case iPhoneSE2Gen
    case iPhone12
    case iPhone12Pro
    case iPhone12ProMax
    case iPhone12Mini
    case iPhone13
    case iPhone13Pro
    case iPhone13ProMax
    case iPhone13Mini
    
    static let baseScreenSize: Device = .iPhone11
}

extension Device: RawRepresentable {
    typealias RawValue = CGSize
    
    init?(rawValue: CGSize) {
        switch rawValue {
        case CGSize(width: 375, height: 667):
            self = .iPhone7
        case CGSize(width: 476, height: 847):
            self = .iPhone7Plus
        case CGSize(width: 375, height: 667):
            self = .iPhone8
        case CGSize(width: 414, height: 736):
            self = .iPhone8Plus
        case CGSize(width: 375, height: 812):
            self = .iPhoneX
        case CGSize(width: 375, height: 812):
            self = .iPhoneXS
        case CGSize(width: 414, height: 896):
            self = .iPhoneXSMax
        case CGSize(width: 414, height: 896):
            self = .iPhoneXR
        case CGSize(width: 414, height: 896):
            self = .iPhone11
        case CGSize(width: 375, height: 812):
            self = .iPhone11Pro
        case CGSize(width: 414, height: 896):
            self = .iPhone11ProMax
        case CGSize(width: 375, height: 667):
            self = .iPhoneSE2Gen
        case CGSize(width: 390, height: 844):
            self = .iPhone12
        case CGSize(width: 390, height: 844):
            self = .iPhone12Pro
        case CGSize(width: 428, height: 926):
            self = .iPhone12ProMax
        case CGSize(width: 375, height: 812):
            self = .iPhone12Mini
        case CGSize(width: 390, height: 844):
            self = .iPhone13
        case CGSize(width: 390, height: 844):
            self = .iPhone13Pro
        case CGSize(width: 428, height: 926):
            self = .iPhone13ProMax
        case CGSize(width: 375, height: 812):
            self = .iPhone13Mini
        default:
           return nil
        }
    }
    
    var rawValue: CGSize {
        switch self {
        case .iPhone7:
            return CGSize(width: 375, height: 667)
        case .iPhone7Plus:
            return CGSize(width: 476, height: 847)
        case .iPhone8:
            return CGSize(width: 375, height: 667)
        case .iPhone8Plus:
            return CGSize(width: 414, height: 736)
        case .iPhoneX:
            return CGSize(width: 375, height: 812)
        case .iPhoneXS:
            return CGSize(width: 375, height: 812)
        case .iPhoneXSMax:
            return CGSize(width: 414, height: 896)
        case .iPhoneXR:
            return CGSize(width: 414, height: 896)
        case .iPhone11:
            return CGSize(width: 414, height: 896)
        case .iPhone11Pro:
            return CGSize(width: 375, height: 812)
        case .iPhone11ProMax:
            return CGSize(width: 414, height: 896)
        case .iPhoneSE2Gen:
            return CGSize(width: 375, height: 667)
        case .iPhone12:
            return CGSize(width: 390, height: 844)
        case .iPhone12Pro:
            return CGSize(width: 390, height: 844)
        case .iPhone12ProMax:
            return CGSize(width: 428, height: 926)
        case .iPhone12Mini:
            return CGSize(width: 375, height: 812)
        case .iPhone13:
            return CGSize(width: 390, height: 844)
        case .iPhone13Pro:
            return CGSize(width: 390, height: 844)
        case .iPhone13ProMax:
            return CGSize(width: 428, height: 926)
        case .iPhone13Mini:
            return CGSize(width: 375, height: 812)
        }
    }
}
