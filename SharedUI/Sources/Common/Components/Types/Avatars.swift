//
//  File.swift
//  
//
//  Created by Raul Batista on 26.12.2023.
//

import Foundation
import SwiftUI
import UIKit

public enum Avatar: CaseIterable {
    case avatarAlert
    case avatarAlien
    case avatarAngry
    case avatarCash
    case avatarClaun
    case avatarCuteSmile
    case avatarGeek
    case avatarGhost
    case avatarInLove
    case avatarJapaneseSmile
    case avatarKiss
    case avatarLOL
    case avatarMonkey
    case avatarMonocle
    case avatarPoop
    case avatarRanger
    case avatarRobot
    case avatarSkull
    case avatarSleepy
    case avatarSmile
    case avatarSmileNotSure
    case avatarStarSmile
    case avatarUnicorn
    case avatarWink

    public var image: Image {
        switch self {
        case .avatarAlert:
            .avatarAlert
        case .avatarAlien:
            .avatarAlien
        case .avatarAngry:
            .avatarAngry
        case .avatarCash:
            .avatarCash
        case .avatarClaun:
            .avatarClaun
        case .avatarCuteSmile:
            .avatarCuteSmile
        case .avatarGeek:
            .avatarGeek
        case .avatarGhost:
            .avatarGhost
        case .avatarInLove:
            .avatarInLove
        case .avatarJapaneseSmile:
            .avatarJapaneseSmile
        case .avatarKiss:
            .avatarKiss
        case .avatarLOL:
            .avatarLOL
        case .avatarMonkey:
            .avatarMonkey
        case .avatarMonocle:
            .avatarMonocle
        case .avatarPoop:
            .avatarPoop
        case .avatarRanger:
            .avatarRanger
        case .avatarRobot:
            .avatarRobot
        case .avatarSkull:
            .avatarSkull
        case .avatarSleepy:
            .avatarSleepy
        case .avatarSmile:
            .avatarSmile
        case .avatarSmileNotSure:
            .avatarSmileNotSure
        case .avatarStarSmile:
            .avatarStarSmile
        case .avatarUnicorn:
            .avatarUnicorn
        case .avatarWink:
            .avatarWink
        }
    }

    public var uiImage: UIImage {
        switch self {
        case .avatarAlert:
            .avatarAlert
        case .avatarAlien:
            .avatarAlien
        case .avatarAngry:
            .avatarAngry
        case .avatarCash:
            .avatarCash
        case .avatarClaun:
            .avatarClaun
        case .avatarCuteSmile:
            .avatarCuteSmile
        case .avatarGeek:
            .avatarGeek
        case .avatarGhost:
            .avatarGhost
        case .avatarInLove:
            .avatarInLove
        case .avatarJapaneseSmile:
            .avatarJapaneseSmile
        case .avatarKiss:
            .avatarKiss
        case .avatarLOL:
            .avatarLOL
        case .avatarMonkey:
            .avatarMonkey
        case .avatarMonocle:
            .avatarMonocle
        case .avatarPoop:
            .avatarPoop
        case .avatarRanger:
            .avatarRanger
        case .avatarRobot:
            .avatarRobot
        case .avatarSkull:
            .avatarSkull
        case .avatarSleepy:
            .avatarSleepy
        case .avatarSmile:
            .avatarSmile
        case .avatarSmileNotSure:
            .avatarSmileNotSure
        case .avatarStarSmile:
            .avatarStarSmile
        case .avatarUnicorn:
            .avatarUnicorn
        case .avatarWink:
            .avatarWink
        }
    }
}
